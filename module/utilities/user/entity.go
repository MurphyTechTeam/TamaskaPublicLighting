package user

import "time"

type User struct {
	User_id      int
	Name         string
	Email        string
	Password     string
	Avatar       string
	Date_updated time.Time
	Date_created time.Time
}

type ListUser struct {
	User_id      int
	Name         string
	Email        string
	Password     string
	Avatar       string
	Date_updated time.Time
	Date_created time.Time
	Role_name    string
	Area_name    string
}

type User_roles struct {
	Id      int
	User_id int
	Role_id int
}

type User_area struct {
	Division_id int
	User_id     int
	Area_id     int
}

type ListRole struct {
	Role_id   int
	Role_name string
	Count     int
}

type ListArea struct {
	Area_id   int
	Area_name string
}

type DelUser struct {
	User_id      int
	Name         string
	Email        string
	Password     string
	Avatar       string
	Date_updated time.Time
	Date_created time.Time
}

type DelRoles struct {
	User_id int
	Role_id int
}

type DelArea struct {
	User_id int
	Area_id int
}
