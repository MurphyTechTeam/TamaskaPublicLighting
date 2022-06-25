package user

import (
	"TamaskaPublicLighting/module/utilities/device"
	"errors"
	"fmt"
	"strconv"
	"time"

	"golang.org/x/crypto/bcrypt"
)

type Service interface {
	Login(input LoginInput) (User, error)
	RegisterUser(input RegisterInput) (User, RoleInput, AreaInput, error)
	GetRoles(id int) ([]User_roles, error)
	InsertRole(input RegisterInput, id int) (RoleInput, error)
	InsertArea(input RegisterInput, id int) (AreaInput, error)
	DeviceCard(deviceD device.Device_dasb, area int) (device.Device_dasb, error)
	PowerConDaily(area string) (float64, float64)
	ListDevice(area int) ([]device.Device_listdasb, error)
	ListUser(user ListUser) ([]ListUser, error)
	ListRole(role ListRole) ([]ListRole, error)
	ListArea(area ListArea) ([]ListArea, error)
	GetUserByID(id int) (User, error)
	UpdateUser(input UpdateUser) (UpdateUser, error)
	DeleteUser(user_id int) (int, error)
	GetArea(userID int) ([]device.AreaDetail, error)
	UserDeviceReporting(searchForm device.ReportDeviceUser) ([]device.ReportResultDevice, error)
	GetCond(parsing device.DeviceCond) ([]device.DeviceCond, error)
	GetRoleId(userID int) (User_roles, error)
	GetAreaId(userID int) (User_area, error)
}

type service struct {
	repository Repository
}

func NewService(repository Repository) *service {
	return &service{repository}
}

func (s *service) Login(input LoginInput) (User, error) {
	email := input.Email
	password := input.Password

	user, err := s.repository.FindByEmail(email)
	if err != nil {
		return user, err
	}

	if user.User_id == 0 {
		return user, errors.New("Username/Password is wrong!")
	}

	err = bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(password))
	if err != nil {
		return user, errors.New("Username/Password is wrong!")
	}

	return user, nil
}
func (s *service) RegisterUser(input RegisterInput) (User, RoleInput, AreaInput, error) {
	user := User{}
	roleinput := RoleInput{}
	areainput := AreaInput{}
	user.Name = input.Nama
	user.Email = input.Email
	passwordHash, err := bcrypt.GenerateFromPassword([]byte(input.Password), bcrypt.MinCost)
	if err != nil {
		return user, roleinput, areainput, err
	}

	user.Password = string(passwordHash)
	//user.Id_role = input.Role
	user.Avatar = "Images/avatar.png"
	newUser, err := s.repository.Save(user)
	if err != nil {
		return newUser, roleinput, areainput, err
	}

	lastInsertID, err := s.repository.GetLastInsertUser(user)
	if err != nil {
		return lastInsertID, roleinput, areainput, err
	}

	roleinput.User_id = lastInsertID.User_id
	insertingRole, err := s.InsertRole(input, roleinput.User_id)
	if err != nil {
		return user, insertingRole, areainput, err
	}

	areainput.User_id = lastInsertID.User_id
	insertingArea, err := s.InsertArea(input, areainput.User_id)
	if err != nil {
		return user, roleinput, insertingArea, err
	}

	return newUser, roleinput, areainput, nil
}

func (s *service) InsertRole(input RegisterInput, id int) (RoleInput, error) {
	roleinput := RoleInput{}

	roleinput.User_id = id

	if input.Role != "" {
		roleinput.Role_id, _ = strconv.Atoi(input.Role)
		bind, err := s.repository.InsertRole(roleinput)
		if err != nil {
			return bind, err
		}

	}
	// if input.Role2 != "" {
	// 	roleinput.Role_id, _ = strconv.Atoi(input.Role2)
	// 	bind, err := s.repository.InsertRole(roleinput)
	// 	if err != nil {
	// 		return bind, err
	// 	}

	// }
	// if input.Role3 != "" {
	// 	roleinput.Role_id, _ = strconv.Atoi(input.Role3)
	// 	bind, err := s.repository.InsertRole(roleinput)
	// 	if err != nil {
	// 		return bind, err
	// 	}

	// }
	// if input.Role4 != "" {
	// 	roleinput.Role_id, _ = strconv.Atoi(input.Role4)
	// 	bind, err := s.repository.InsertRole(roleinput)
	// 	if err != nil {
	// 		return bind, err
	// 	}
	// }
	return roleinput, nil
}

func (s *service) InsertArea(input RegisterInput, id int) (AreaInput, error) {
	areainput := AreaInput{}

	areainput.User_id = id

	areainput.Area_id, _ = strconv.Atoi(input.Area)
	bind, err := s.repository.InsertArea(areainput)
	if err != nil {
		return bind, err
	}
	return areainput, nil
}

func (s *service) GetRoles(id int) ([]User_roles, error) {
	role, err := s.repository.GetRoles(id)
	if err != nil {
		return role, err
	}

	return role, nil
}

func (s *service) DeviceCard(deviceD device.Device_dasb, area int) (device.Device_dasb, error) {
	device, err := s.repository.DeviceCard(deviceD, area)
	if err != nil {
		return device, err
	}

	return device, nil
}

func (s *service) PowerConDaily(area string) (float64, float64) {
	var now = time.Now() //Get Daily Now
	dateNow := fmt.Sprintf("%d-%02d-%02d", now.Year(), int(now.Month()), now.Day())
	energy, data := s.repository.PowerConDaily(dateNow, area)

	return energy, data
}

func (s *service) ListDevice(area int) ([]device.Device_listdasb, error) {
	device, err := s.repository.ListDevice(area)

	if err != nil {
		return device, err
	}
	//Formatter Time to WIB
	for i, d := range device {
		dd := &device[i]
		dd.Device_lastFormatter = d.Device_last.Format("15:04:05 WIB 02-01-2006")
	}

	return device, nil
}

func (s *service) ListUser(user ListUser) ([]ListUser, error) {
	userL, err := s.repository.ListUser(user)

	if err != nil {
		return userL, err
	}
	return userL, nil
}

func (s *service) ListRole(role ListRole) ([]ListRole, error) {
	roleL, err := s.repository.ListRole(role)

	if err != nil {
		return roleL, err
	}
	return roleL, nil
}

func (s *service) ListArea(area ListArea) ([]ListArea, error) {
	areaL, err := s.repository.ListArea(area)

	if err != nil {
		return areaL, err
	}
	return areaL, nil
}

func (s *service) GetUserByID(ID int) (User, error) {
	user, err := s.repository.GetUserByID(ID)
	if err != nil {
		return user, err
	}

	if user.User_id == 0 {
		return user, errors.New("No user found on with that ID")
	}

	return user, nil
}

func (s *service) UpdateUser(input UpdateUser) (UpdateUser, error) {
	userUpdate := UpdateUser{}
	userUpdate.User_id = input.User_id
	userUpdate.Nama = input.Nama
	userUpdate.Email = input.Email
	userUpdate.Role = input.Role
	userUpdate.Area = input.Area
	userUpdate.Id_user_role = input.Id_user_role
	userUpdate.Id_user_area = input.Id_user_area
	//userUpdate.Password = input.Password

	passwordHash, err := bcrypt.GenerateFromPassword([]byte(input.Password), bcrypt.MinCost)
	if err != nil {
		return userUpdate, err
	}

	userUpdate.Password = string(passwordHash)

	userUpdateData, err := s.repository.UpdateUser(userUpdate)
	if err != nil {
		return userUpdateData, err
	}

	fmt.Println(userUpdate)
	return userUpdate, nil
}

func (s *service) GetRoleId(userID int) (User_roles, error) {
	roleData, err := s.repository.GetRoleId(userID)
	if err != nil {
		return roleData, err
	}
	return roleData, nil
}

func (s *service) GetAreaId(userID int) (User_area, error) {
	areaData, err := s.repository.GetAreaId(userID)
	if err != nil {
		return areaData, err
	}
	return areaData, nil
}

func (s *service) DeleteUser(user_id int) (int, error) {
	user_id, err := s.repository.DeleteUser(user_id)
	if err != nil {
		return 0, err
	}
	return user_id, nil
}

func (s *service) GetArea(userID int) ([]device.AreaDetail, error) {
	areaData, err := s.repository.GetArea(userID)
	if err != nil {
		return areaData, err
	}
	return areaData, nil
}

func (s *service) GetCond(parsing device.DeviceCond) ([]device.DeviceCond, error) {
	condData, err := s.repository.GetCond(parsing)
	if err != nil {
		return condData, err
	}
	return condData, nil
}

func (s *service) UserDeviceReporting(searchForm device.ReportDeviceUser) ([]device.ReportResultDevice, error) {
	reportDev, err := s.repository.GetReportDeviceUser(searchForm)
	if err != nil {
		return reportDev, err
	}

	for i, d := range reportDev {
		dd := &reportDev[i]
		dd.Device_lastFormatter = d.History_date.Format("15:04:05 WIB 02-01-2006")
	}
	return reportDev, err
}
