package device

import "time"

type IdDevice struct {
	IdList []string `json:"m2m:uril"`
}

type Device struct {
	Name          string   `json:"rn"`  //rn
	IdApplication string   `json:"pi"`  //pi
	IdDevice      string   `json:"ri"`  //ri
	Devicelbl     []string `json:"lbl"` //lbl
	CreatedTime   string   `json:"ct"`  //ct
	LastModTime   string   `json:"lt"`  //lt
}
type DetailDevice struct {
	Detail Device `json:"m2m:cnt"`
}

type ListDevice struct {
	Device []Device
}

type Device_dasb struct {
	Device_total    int
	Device_broken   int
	Device_activate int
}

type Device_listdasb struct {
	Device_id            int
	Device_name          string
	Device_cons          int
	Manual_Control       int `gorm:"column:manual_Control"`
	Device_last          time.Time
	Device_lastFormatter string
	Longitude            string
	Latitude             string
}

type DelDevice struct {
	Device_id      int
	Area_id        int
	Antares_id     string
	Device_name    string
	Device_address string
	Device_eui     string
	Longitude      string
	Latitude       string
	Device_cons    string
	Device_sts     int
	device_last    time.Time
}

type DelDeviceC struct {
	DeviceC_id     int
	Device_id      int
	Manual_control int
	Restart_sts    int
	Alarm_type     int
	Hour_on        string
	Minutes_on     string
	Hour_off       string
	Minutes_off    string
	Interval_loop  int
	Interval_send  int
	Bluetooth      int
	Totalisator    int
	Lamp_treshold  int
}

type DelDeviceM struct {
	DeviceM_id  int
	Device_id   int
	Energy      float64
	Power       float64
	Voltage     float64
	Ampere      float64
	PowerFactor float64
	LightSensor float64
	Battery     float64
	Brightness  float64
}

type PowerCon struct {
	History_id   int
	Device_id    int
	Energy       float64
	History_date time.Time
}

type AreaDetail struct {
	Area_id			int
	Cust_id			string
	Antares_apps	string
	Area_name		string
	Area_location	string
	Area_last		time.Time
	Division_id		int
	User_id			int
}

type DeviceCond struct {
	Id		int
	Cons_name		string
	Date_created	time.Time
}
type Coordinate struct {
	Device_id   int
	Device_name string
	Device_cons int
	Longitude   string
	Latitude    string
}

type ReportResultDevice struct {
	Device_id		int
	Cons_name		string
	History_date	time.Time
	Device_lastFormatter string
}