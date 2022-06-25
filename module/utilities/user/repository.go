package user

import (
	"TamaskaPublicLighting/module/utilities/device"
	"database/sql"
	"fmt"

	"gorm.io/gorm"
)

type Repository interface {
	FindByEmail(email string) (User, error)
	Save(user User) (User, error)
	GetRoles(id int) ([]User_roles, error)
	GetLastInsertUser(person User) (User, error)
	InsertRole(role RoleInput) (RoleInput, error)
	InsertArea(area AreaInput) (AreaInput, error)
	DeviceCard(DeviceD device.Device_dasb, area int) (device.Device_dasb, error)
	PowerConDaily(date string, area string) (float64, float64)
	ListDevice(area int) ([]device.Device_listdasb, error)
	ListUser(user ListUser) ([]ListUser, error)
	ListRole(role ListRole) ([]ListRole, error)
	ListArea(area ListArea) ([]ListArea, error)
	GetUserByID(ID int) (User, error)
	UpdateUser(input UpdateUser) (UpdateUser, error)
	DeleteUser(user_id int) (int, error)
	GetArea(userID int) ([]device.AreaDetail, error)
	GetCond(input device.DeviceCond) ([]device.DeviceCond, error)
	GetRoleId(userID int) (User_roles, error)
	GetAreaId(userID int) (User_area, error)
	GetReportDeviceUser(searchForm device.ReportDeviceUser) ([]device.ReportResultDevice, error)
}

type repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *repository {
	return &repository{db}
}

func (r *repository) FindByEmail(email string) (User, error) {
	var user User

	err := r.db.Where("email = ?", email).Find(&user).Error
	if err != nil {
		return user, err
	}

	return user, nil
}
func (r *repository) Save(user User) (User, error) {
	err := r.db.Create(&user).Error
	if err != nil {
		return user, err
	}
	//fmt.Println(user)
	return user, nil
}

func (r *repository) GetRoles(id int) ([]User_roles, error) {
	var role []User_roles

	err := r.db.Where("user_id = ?", id).Find(&role).Error
	if err != nil {
		return role, err
	}

	return role, nil
}

func (r *repository) GetLastInsertUser(person User) (User, error) {
	var user User
	err := r.db.Select("user_id").Last(&user).Error
	if err != nil {
		return user, err
	}
	fmt.Println(user)
	return user, nil
}

func (r *repository) InsertRole(role RoleInput) (RoleInput, error) {
	err := r.db.Table("user_roles").Create(&role).Error
	if err != nil {
		return role, err
	}
	return role, nil
}

func (r *repository) InsertArea(area AreaInput) (AreaInput, error) {
	err := r.db.Table("area_division").Create(&area).Error
	if err != nil {
		return area, err
	}
	return area, nil
}

func (r *repository) DeviceCard(DeviceD device.Device_dasb, area int) (device.Device_dasb, error) {
	//Get Total All device
	err := r.db.Raw("SELECT COUNT(device_id) FROM device WHERE area_id = ?", area).Scan(&DeviceD.Device_total).Error
	//Get Total Broken device
	err2 := r.db.Raw("SELECT COUNT(device_id) FROM device WHERE area_id = ? AND device_sts = ?", area, 3).Scan(&DeviceD.Device_broken).Error
	//Get Total Working device
	err3 := r.db.Raw("SELECT COUNT(device_id) FROM device WHERE area_id = ? AND device_sts = ?", area, 1).Scan(&DeviceD.Device_activate).Error

	if err != nil || err2 != nil || err3 != nil {
		return DeviceD, err
	}

	return DeviceD, nil
}

func (r *repository) PowerConDaily(date string, area string) (float64, float64) {
	var totEnergy float64
	var totData float64
	row := r.db.Raw("SELECT SUM(dh.energy) AS totEnergy, count(dh.energy) AS totData FROM device d INNER JOIN device_history dh ON d.device_id=dh.device_id WHERE dh.history_date LIKE '"+date+"%' AND d.area_id=?", area).Row()
	row.Scan(&totEnergy, &totData)
	return totEnergy, totData
}

func (r *repository) ListDevice(area int) ([]device.Device_listdasb, error) {
	var listDevice []device.Device_listdasb
	err := r.db.Raw("SELECT d.device_id, d.device_name, d.device_cons, dc.manual_Control, d.device_last, d.longitude, d.latitude FROM device d INNER JOIN device_controlling dc ON d.device_id=dc.device_id WHERE d.area_id=?", area).Scan(&listDevice).Error
	if err != nil {
		return listDevice, err
	}
	return listDevice, nil
}

func (r *repository) ListUser(user ListUser) ([]ListUser, error) {
	var listUser []ListUser
	err := r.db.Raw("SELECT u.user_id, u.name, u.email, dr.role_name, a.area_name FROM users AS u LEFT JOIN user_roles AS ur ON ur.user_id = u.user_id LEFT JOIN detail_roles AS dr ON dr.role_id = ur.role_id LEFT JOIN area_division AS ad ON ad.user_id = u.user_id LEFT JOIN area AS a ON a.area_id = ad.area_id GROUP BY u.user_id").Scan(&listUser).Error
	if err != nil {
		return listUser, err
	}
	return listUser, nil
}

func (r *repository) ListRole(role ListRole) ([]ListRole, error) {
	var listRole []ListRole
	err := r.db.Raw("SELECT dr.role_id, dr.role_name, COUNT(ur.role_id) AS count FROM detail_roles AS dr LEFT JOIN user_roles AS ur ON ur.role_id = dr.role_id GROUP BY dr.role_id;").Scan(&listRole).Error
	if err != nil {
		return listRole, err
	}
	return listRole, nil
}

func (r *repository) ListArea(role ListArea) ([]ListArea, error) {
	var ListArea []ListArea
	err := r.db.Raw("SELECT * FROM area;").Scan(&ListArea).Error
	if err != nil {
		return ListArea, err
	}
	return ListArea, nil
}

func (r *repository) GetUserByID(ID int) (User, error) {
	var user User
	err := r.db.Where("user_id = ?", ID).Find(&user).Error
	if err != nil {
		return user, err
	}
	return user, nil
}

func (r *repository) GetRoleId(userID int) (User_roles, error) {
	var roleData User_roles
	err := r.db.Raw("SELECT id FROM user_roles WHERE user_id = ?", userID).Scan(&roleData).Error
	if err != nil {
		return roleData, err
	}
	return roleData, nil
}

func (r *repository) GetAreaId(userID int) (User_area, error) {
	var areaData User_area
	err := r.db.Raw("SELECT division_id FROM area_division WHERE user_id = ?", userID).Scan(&areaData).Error
	if err != nil {
		return areaData, err
	}
	return areaData, nil
}

func (r *repository) UpdateUser(input UpdateUser) (UpdateUser, error) {
	err := r.db.Exec("UPDATE users SET name = @name, email = @email, password = @password WHERE user_id = @user_id", sql.Named("name", input.Nama), sql.Named("email", input.Email), sql.Named("password", input.Password), sql.Named("user_id", input.User_id))
	err2 := r.db.Exec("REPLACE INTO user_roles (id, user_id, role_id) VALUES (@id_user_role, @user_id, @role_id);", sql.Named("id_user_role", input.Id_user_role), sql.Named("user_id", input.User_id), sql.Named("role_id", input.Role))
	err3 := r.db.Exec("REPLACE INTO area_division (division_id, user_id, area_id) VALUES (@id_user_area, @user_id, @area_id);", sql.Named("id_user_area", input.Id_user_area), sql.Named("user_id", input.User_id), sql.Named("area_id", input.Area))

	if err != nil || err2 != nil || err3 != nil {
		return input, nil
	}
	return input, nil
}

func (r *repository) DeleteUser(user_id int) (int, error) {
	err := r.db.Table("users").Where("user_id = ?", user_id).Delete(&DelUser{}).Error
	err2 := r.db.Table("user_roles").Where("user_id = ?", user_id).Delete(&DelRoles{}).Error
	err3 := r.db.Table("area_division").Where("user_id = ?", user_id).Delete(&DelArea{}).Error

	if err != nil || err2 != nil || err3 != nil {
		return 0, err
	}

	return 1, nil
}

func (r *repository) GetArea(userID int) ([]device.AreaDetail, error) {
	var detilArea []device.AreaDetail
	err := r.db.Raw("SELECT area.*, area_division.division_id, area_division.user_id FROM area LEFT JOIN area_division ON area.area_id = area_division.area_id WHERE user_id = ?",
		userID).Scan(&detilArea).Error
	if err != nil {
		return detilArea, err
	}
	return detilArea, nil
}

func (r *repository) GetCond(input device.DeviceCond) ([]device.DeviceCond, error) {
	var devCond []device.DeviceCond
	err := r.db.Table("device_cons_d").Find(&devCond).Error
	if err != nil {
		return devCond, err
	}
	return devCond, nil
}

func (r *repository) GetReportDeviceUser(searchForm device.ReportDeviceUser) ([]device.ReportResultDevice, error) {
	var reportDevice []device.ReportResultDevice
	err := r.db.Raw("SELECT device_history.device_id, device_cons_d.cons_name, device_history.history_date FROM device_history LEFT JOIN device_cons_d ON device_history.device_cons = device_cons_d.id LEFT JOIN device ON device_history.device_id = device.device_id WHERE device.area_id = ? AND device_cons_d.id = ? AND device_history.history_date >= ? AND device_history.history_date <= ? GROUP BY device_history.history_date",
		searchForm.Area_id, searchForm.Dev_cons_id, searchForm.StartDate, searchForm.EndDate).Scan(&reportDevice).Error
	if err != nil {
		return reportDevice, err
	}
	return reportDevice, err
}
