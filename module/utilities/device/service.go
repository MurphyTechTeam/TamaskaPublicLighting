package device

import (
	"fmt"
	"time"
)

type Service interface {
	GetAllDevice() ([]Device, error)
	ManualControl(power string, device string) (int, error)
	AddingDevice(input AddDeviceInput) (AddDeviceInput, DeviceControllingInput, DeviceMonitoringInput, error)
	EditingDevice(input UpdateDevice) (UpdateDevice, error)
	DeleteDevice(ID int) (int, error)
	BindWhData(input DeviceHistory) (DeviceHistory, error)
	PowerConsumption(area int, input IdDeviceHistory) ([]PowerCon, error)
	AllCoordinate(area int) ([]Coordinate, error)
	CoordinateByID(area int, id int) ([]Coordinate, error)
	BrightnessControl(brightness int, device string) (int, error)
}

type service struct {
	repository Repository
}

func NewService(repository Repository) *service {
	return &service{repository}
}

func (dev *ListDevice) AddDevice(d Device) {
	dev.Device = append(dev.Device, d)
}

func (s *service) GetAllDevice() ([]Device, error) {
	var detail Device
	list := ListDevice{}

	id, err := s.repository.GetIdDevice()
	if err != nil {
		return nil, err
	}

	for _, str := range id {
		detail, err = s.repository.GetDetailDevice(str)
		if err != nil {
			return nil, err
		}
		list.AddDevice(detail)
	}
	return list.Device, nil
}
func (s *service) ManualControl(power string, device string) (int, error) {

	id, err := s.repository.ManualControl(power, device)
	if err != nil {
		return 0, err
	}
	return id, nil
}

func (s *service) AddingDevice(input AddDeviceInput) (AddDeviceInput, DeviceControllingInput, DeviceMonitoringInput, error) {
	device := AddDeviceInput{}
	controlling := DeviceControllingInput{}
	monitoring := DeviceMonitoringInput{}
	device.Area_id = input.Area_id
	device.Antares_id = input.Antares_id
	device.Device_name = input.Device_name
	device.Device_eui = input.Device_eui
	device.Device_address = input.Device_address
	device.Longitude = input.Longitude
	device.Latitude = input.Latitude
	device.Device_cons = input.Device_cons
	device.Device_sts = input.Device_sts

	newDevice, err := s.repository.AddDevice(device)
	if err != nil {
		return newDevice, controlling, monitoring, nil
	}

	lastInsertDevice, err := s.repository.GetLastInsertDevice(controlling)
	if err != nil {
		return device, lastInsertDevice, monitoring, nil
	}

	monitoring.Device_id = lastInsertDevice.Device_id

	insertDeviceControlling, err := s.repository.InsertDeviceControlling(lastInsertDevice)
	if err != nil {
		return device, insertDeviceControlling, monitoring, nil
	}

	return device, controlling, monitoring, nil
}

func (s *service) EditingDevice(input UpdateDevice) (UpdateDevice, error) {
	deviceUpdate := UpdateDevice{}
	deviceUpdate.Device_id = input.Device_id
	deviceUpdate.Device_sts = input.Device_sts
	deviceUpdate.Longitude = input.Longitude
	deviceUpdate.Latitude = input.Latitude

	updateDeviceData, err := s.repository.UpdateDevice(deviceUpdate)
	if err != nil {
		return updateDeviceData, err
	}

	fmt.Println(deviceUpdate)
	return deviceUpdate, nil
}
func (s *service) DeleteDevice(ID int) (int, error) {
	id, err := s.repository.DeleteDevice(ID)
	if err != nil {
		return 0, err
	}
	return id, nil
}

func (s *service) BindWhData(input DeviceHistory) (DeviceHistory, error) {
	bindData := DeviceHistory{}
	bindData = input
	bindData.HistoryDate = time.Now()
	bind, err := s.repository.WebhookInsertData(bindData)
	if err != nil {
		return bind, err
	}
	fmt.Println(bindData)
	return bindData, nil
}

func (s *service) PowerConsumption(area int, input IdDeviceHistory) ([]PowerCon, error) {
	PowerCon, err := s.repository.PowerConsumption(area, input)
	if err != nil {
		return PowerCon, err
	}

	return PowerCon, nil
}
func (s *service) AllCoordinate(area int) ([]Coordinate, error) {
	Coordinate, err := s.repository.AllCoordinate(area)
	if err != nil {
		return Coordinate, err
	}
	return Coordinate, nil
}

func (s *service) CoordinateByID(area int, id int) ([]Coordinate, error) {
	Coordinate, err := s.repository.CoordinateByID(area, id)
	if err != nil {
		return Coordinate, err
	}
	return Coordinate, nil
}

func (s *service) BrightnessControl(brightness int, device string) (int, error) {
	id, err := s.repository.BrightnessControl(brightness, device)
	if err != nil {
		return 0, err
	}
	return id, nil
}
