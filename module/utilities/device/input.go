package device

import "time"

type AddDeviceInput struct {
	Area_id        int    `json:"area_id" form:"area_id" binding:"required"`
	Antares_id     string `json:"antares_id" form:"antares_id" binding:"required"`
	Device_name    string `json:"device_name" form:"device_name" binding:"required"`
	Device_address string `json:"device_address" form:"device_address" binding:"required"`
	Device_eui     string `json:"device_eui" form:"device_eui" binding:"required"`
	Longitude      string `json:"longitude" form:"longitude" binding:"required"`
	Latitude       string `json:"latitude" form:"latitude" binding:"required"`
	Device_cons    string `json:"device_cons" form:"device_cons" binding:"required"`
	Device_sts     int    `json:"device_sts" form:"device_sts" binding:"required"`
}

type DeviceControllingInput struct {
	Device_id      int    `json:"device_id" form:"device_id" binding:"required"`
	Manual_control int    `json:"manual_control" form:"manual_control" `
	Restart_sts    int    `json:"restart_sts" form:"restart_sts" `
	Alarm_type     int    `json:"alarm_type" form:"alarm_type" `
	Hour_on        string `json:"hour_on" form:"hour_on" `
	Minutes_on     string `json:"minutes_on" form:"minutes_on" `
	Hour_off       string `json:"hour_off" form:"hour_off" `
	Minutes_off    string `json:"minutes_off" form:"minutes_off" `
	Interval_loop  int    `json:"interval_loop" form:"interval_loop" `
	Interval_send  int    `json:"interval_send" form:"interval_send" `
	Bluetooth      int    `json:"bluetooth" form:"bluetooth" `
	Totalisator    int    `json:"totalisator" form:"totalisator" `
	Lamp_treshold  int    `json:"lamp_treshold" form:"lamp_treshold" `
}

type DeviceMonitoringInput struct {
	Device_id   int     `json:"device_id" form:"device_id" binding:"required"`
	Energy      float64 `json:"energy" form:"energy"`
	Power       float64 `json:"power" form:"power"`
	Voltage     float64 `json:"voltage" form:"voltage"`
	Ampere      float64 `json:"ampere" form:"ampere"`
	Powerf      float64 `json:"powerf" form:"powerf"`
	LightSensor float64 `json:"lightsensor" form:"lightsensor"`
	Battery     float64 `json:"battery" form:"battery"`
	Brightness  float64 `json:"brightness" form:"brightness"`
}

type UpdateDevice struct {
	Device_id  int    `json:"device_id" form:"device_id" binding:"required"`
	Longitude  string `json:"longitude" form:"longitude" binding:"required"`
	Latitude   string `json:"latitude" form:"latitude" binding:"required"`
	Device_sts int    `json:"device_sts" form:"device_sts" binding:"required"`
}

type DeviceHistory struct {
	Device_id   int       	`json:"device_id"`
	Energy      float64   	`json:"energy"`
	Power       float64   	`json:"power"`
	Voltage     float64   	`json:"voltage"`
	Ampere      float64   	`json:"ampere"`
	PowerFactor float64   	`json:"powerFactor"`
	LightSensor float64   	`json:"lightSensor"`
	Battery     float64   	`json:"battery"`
	Brightness  float64   	`json:"brightness"`
	Device_cons	int			`json:"device_cons"`
	HistoryDate time.Time 	`json:"history_date"`
}

type IdDeviceHistory struct {
	Device_id int `json:"device_id" binding:"required"`
}

type ReportDeviceUser struct {
	Device_id	int	`json:"device_id" form:"device_id"`
	Area_id		int	`json:"area_id" form:"area_id"`
	Dev_cons_id	int	`json:"dev_cons_id" form:"dev_cons_id"`
	Cons_name	string	`json:"cons_name" form:"cons_name"`
	StartDate	string	`json:"start_date" form:"start_date"`
	EndDate		string	`json:"end_date" form:"end_date"`
}