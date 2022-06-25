package device

import (
	"TamaskaPublicLighting/app/auth"
	"bytes"
	"crypto/tls"
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"
	"strings"
	"time"

	"gorm.io/gorm"
)

type Repository interface {
	GetIdDevice() ([]string, error)
	GetDetailDevice(id string) (Device, error)
	ManualControl(power string, device string) (int, error)
	AddDevice(device AddDeviceInput) (AddDeviceInput, error)
	GetLastInsertDevice(input DeviceControllingInput) (DeviceControllingInput, error)
	InsertDeviceControlling(input DeviceControllingInput) (DeviceControllingInput, error)
	UpdateDevice(input UpdateDevice) (UpdateDevice, error)
	DeleteDevice(ID int) (int, error)
	WebhookInsertData(input DeviceHistory) (DeviceHistory, error)
	PowerConsumption(area int, input IdDeviceHistory) ([]PowerCon, error)
	AllCoordinate(area int) ([]Coordinate, error)
	CoordinateByID(area int, id int) ([]Coordinate, error)
	BrightnessControl(brightness int, device string) (int, error)
}

type repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *repository {
	return &repository{db}
}

func (r *repository) GetIdDevice() ([]string, error) {
	tr := &http.Transport{
		TLSClientConfig: &tls.Config{
			MaxVersion: tls.VersionTLS12,
		},
	}
	client := &http.Client{Transport: tr}

	req, err := http.NewRequest("GET", auth.ApplicationURL+"?fu=1&ty=3", nil)
	req.Header.Add("X-M2M-Origin", auth.SECRET_ANTARES)
	req.Header.Add("Content-Type", "application/json")
	req.Header.Add("Accept", "application/json")

	if err != nil {
		log.Fatalln(err)
		return nil, err
	}

	resp, err := client.Do(req)

	if err != nil {
		log.Fatalln(err)
		fmt.Println(err)
	}
	body, _ := ioutil.ReadAll(resp.Body)
	var d IdDevice
	str := string(body)
	str = strings.Replace(str, "/antares-cse/antares-id/"+auth.ApplicationAntares+"/", "", -1)
	json.Unmarshal([]byte(str), &d)

	return d.IdList, err
}

func (r *repository) GetDetailDevice(id string) (Device, error) {
	tr := &http.Transport{
		TLSClientConfig: &tls.Config{
			MaxVersion: tls.VersionTLS12,
		},
	}
	client := &http.Client{Transport: tr}

	req, err := http.NewRequest("GET", auth.ApplicationURL+"/"+id, nil)
	req.Header.Add("X-M2M-Origin", auth.SECRET_ANTARES)
	req.Header.Add("Content-Type", "application/json")
	req.Header.Add("Accept", "application/json")

	if err != nil {
		log.Fatalln(err)
		return Device{}, err
	}

	resp, err := client.Do(req)

	if err != nil {
		log.Fatalln(err)
		return Device{}, err
	}
	body, _ := ioutil.ReadAll(resp.Body)
	str := string(body)
	str = strings.Replace(str, "LoRaDeviceEUI/", "", -1)
	str = strings.Replace(str, "LoRaDeviceAddress/", "", -1)
	str = strings.Replace(str, "LoRaDeviceId/", "", -1)
	str = strings.Replace(str, "/antares-cse/", "", -1)
	var d DetailDevice
	json.Unmarshal([]byte(str), &d)

	return d.Detail, nil
}

func (r *repository) ManualControl(power string, device string) (int, error) {

	data := "\r\n{\r\n  \"m2m:cin\": {\r\n    \"con\": \r\n      \"{\r\n      \t \\\"type\\\":\\\"downlink\\\",\r\n         \\\"port\\\": 1\r\n,\r\n         \\\"data\\\":\\\"" + power + "\\\"\r\n      }\"\r\n    }\r\n}"

	timeout := time.Duration(5 * time.Second)
	client := http.Client{
		Timeout: timeout,
	}
	req, err := http.NewRequest("POST", auth.ApplicationSCN+device, bytes.NewBuffer([]byte(data)))
	req.Header.Set("X-Client-Key", auth.SECRET_SCNHUB)
	req.Header.Set("Content-Type", "application/json;ty=4")
	req.Header.Set("Accept", "application/json")

	if err != nil {
		log.Fatalln(err)
		return 0, err
	}

	resp, err := client.Do(req)
	if err != nil {
		log.Fatalln(err)
		return 0, err
	}

	_, err = ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatalln(err)
		return 0, err
	}
	//Update Manual Control Device and Device Condition in Database
	r.db.Exec("UPDATE device d INNER JOIN device_controlling dc ON d.device_id = dc.device_id SET dc.manual_Control = " + strings.Replace(power, "000", "", -1) + ", d.device_cons = " + strings.Replace(power, "000", "", -1) + " WHERE d.device_name = \"" + device + "\"")
	//log.Println(string(body))
	return 1, nil
}

func (r *repository) AddDevice(device AddDeviceInput) (AddDeviceInput, error) {
	err := r.db.Table("device").Create(&device).Error
	if err != nil {
		return device, err
	}
	//fmt.Println(device)
	return device, nil
}

func (r *repository) GetLastInsertDevice(input DeviceControllingInput) (DeviceControllingInput, error) {
	var deviceC DeviceControllingInput
	err := r.db.Table("device").Select("device_id").Last(&deviceC).Error
	if err != nil {
		return deviceC, err
	}
	return deviceC, nil
}

func (r *repository) InsertDeviceControlling(input DeviceControllingInput) (DeviceControllingInput, error) {
	err := r.db.Table("device_controlling").Create(&input).Error
	if err != nil {
		return input, err
	}

	sent := r.db.Exec("INSERT INTO device_monitoring (`device_id`, `energy`, `power`, `voltage`, `ampere`, `powerFactor`, `lightSensor`, `battery`, `brightness`) VALUES (@did,0,0,0,0,0,0,0,0)", sql.Named("did", input.Device_id))
	if sent != nil {
		return input, err
	}

	return input, nil
}

func (r *repository) UpdateDevice(input UpdateDevice) (UpdateDevice, error) {
	err := r.db.Exec("UPDATE device SET longitude = @longitude, latitude = @latitude, device_sts = @device_sts WHERE device_id = @device_id", sql.Named("longitude", input.Longitude), sql.Named("latitude", input.Latitude), sql.Named("device_sts", input.Device_sts), sql.Named("device_id", input.Device_id))
	if err != nil {
		return input, nil
	}
	return input, nil
}
func (r *repository) DeleteDevice(ID int) (int, error) {
	err := r.db.Table("device").Where("device_id = ?", ID).Delete(&DelDevice{}).Error
	err2 := r.db.Table("device_controlling").Where("device_id = ?", ID).Delete(&DelDeviceC{}).Error
	err3 := r.db.Table("device_monitoring").Where("device_id = ?", ID).Delete(&DelDeviceM{}).Error

	if err != nil || err2 != nil || err3 != nil {
		return 0, err
	}

	return 1, nil
}

func (r *repository) WebhookInsertData(input DeviceHistory) (DeviceHistory, error) {
	err := r.db.Exec("INSERT INTO device_history (`device_id`, `energy`, `power`, `voltage`, `ampere`, `powerFactor`, `lightSensor`, `battery`, `brightness`, `device_cons`) VALUES (@did,@energy,@power,@voltage,@ampere,@powerfactor,@lightsensor,@battery,@brightness,@devicecons)",
		sql.Named("did", input.Device_id), sql.Named("energy", input.Energy), sql.Named("power", input.Power), sql.Named("voltage", input.Voltage), sql.Named("ampere", input.Ampere), sql.Named("powerfactor", input.PowerFactor), sql.Named("lightsensor", input.LightSensor),
		sql.Named("battery", input.Battery), sql.Named("brightness", input.Brightness), sql.Named("devicecons", input.Device_cons)).Error
	err2 := r.db.Exec("UPDATE device_monitoring SET energy = @energy, power = @power, voltage = @voltage, ampere = @ampere, powerFactor = @powerfactor, lightSensor = @lightsensor, battery = @battery, brightness = @brightness WHERE device_id = @device_id",
		sql.Named("energy", input.Energy), sql.Named("power", input.Power), sql.Named("voltage", input.Voltage), sql.Named("ampere", input.Ampere), sql.Named("powerfactor", input.PowerFactor), sql.Named("lightsensor", input.LightSensor), sql.Named("battery", input.Battery),
		sql.Named("brightness", input.Brightness), sql.Named("device_id", input.Device_id)).Error
	if err != nil || err2 != nil {
		return input, nil
	}
	return input, nil
}

func (r *repository) PowerConsumption(area int, input IdDeviceHistory) ([]PowerCon, error) {
	var powerCon []PowerCon
	err := r.db.Raw("SELECT dh.history_id, dh.device_id, dh.energy, dh.history_date FROM device d RIGHT JOIN device_history dh ON d.device_id=dh.device_id WHERE d.area_id=? AND dh.device_id=? AND dh.history_date >= DATE_SUB(NOW(),INTERVAL 1 YEAR);", area, strconv.Itoa(input.Device_id)).Scan(&powerCon).Error
	if err != nil {
		return powerCon, err
	}
	return powerCon, nil
}
func (r *repository) AllCoordinate(area int) ([]Coordinate, error) {
	var coordinate []Coordinate
	err := r.db.Raw("SELECT d.device_id, d.device_name, d.device_cons, d.longitude, d.latitude FROM device d INNER JOIN device_controlling dc ON d.device_id=dc.device_id WHERE d.area_id=?", area).Scan(&coordinate).Error
	if err != nil {
		return coordinate, err
	}
	return coordinate, nil
}

func (r *repository) CoordinateByID(area int, id int) ([]Coordinate, error) {
	var coordinate []Coordinate
	err := r.db.Raw("SELECT d.device_id, d.device_name, d.device_cons, d.longitude, d.latitude FROM device d INNER JOIN device_controlling dc ON d.device_id=dc.device_id WHERE d.area_id=? AND d.device_id=?", area, id).Scan(&coordinate).Error
	if err != nil {
		return coordinate, err
	}
	return coordinate, nil
}

func numToHex(decimal int64) string {
	hexa := strconv.FormatInt(decimal, 16)
	return hexa
}

func (r *repository) BrightnessControl(brightness int, device string) (int, error) {
	data := "\r\n{\r\n  \"m2m:cin\": {\r\n    \"con\": \r\n      \"{\r\n      \t \\\"type\\\":\\\"downlink\\\",\r\n         \\\"port\\\": 1\r\n,\r\n         \\\"data\\\":\\\"01" + numToHex(int64(brightness)) + "\\\"\r\n      }\"\r\n    }\r\n}"

	timeout := time.Duration(5 * time.Second)
	client := http.Client{
		Timeout: timeout,
	}
	req, err := http.NewRequest("POST", auth.ApplicationSCN+device, bytes.NewBuffer([]byte(data)))
	req.Header.Set("X-Client-Key", auth.SECRET_SCNHUB)
	req.Header.Set("Content-Type", "application/json;ty=4")
	req.Header.Set("Accept", "application/json")

	if err != nil {
		log.Fatalln(err)
		return 0, err
	}

	resp, err := client.Do(req)
	if err != nil {
		log.Fatalln(err)
		return 0, err
	}

	_, err = ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatalln(err)
		return 0, err
	}
	//Update Brightness in Database
	r.db.Exec("UPDATE device d INNER JOIN device_monitoring dm ON d.device_id = dm.device_id SET dm.brightness = " + strconv.Itoa(brightness) + " WHERE d.device_name = \"" + device + "\"")
	return 1, nil
}
