package view

import (
	"TamaskaPublicLighting/module/utilities/device"
	"TamaskaPublicLighting/module/utilities/user"
	"fmt"
	"net/http"
	"strconv"
	"time"

	"github.com/dustin/go-humanize"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
)

type userView struct {
	userService user.Service
}

func NewUserView(userService user.Service) *userView {
	return &userView{userService}
}

func Tanggal(t time.Time) string {
	return fmt.Sprintf("%s, %02d %s | %02d:%02d",
		hari[t.Weekday()], t.Day(), bulan[t.Month()-1][:3], t.Hour(), int(t.Minute()),
	)
}

var hari = [...]string{
	"Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"}

var bulan = [...]string{
	"Jan", "Feb", "Mar", "Apr", "Mei", "Jun",
	"Jul", "Agu", "Sep", "Okt", "Nop", "Des",
}

func (h *userView) Login(c *gin.Context) {
	session := sessions.Default(c)
	if session.Get("userID") != nil { //If logged in
		c.Redirect(http.StatusFound, "/public-lighting/dashboard")
		return
	}
	c.HTML(http.StatusOK, "login", gin.H{
		"title": "Tamaska Public Lighting Login",
	})
}

func (h *userView) Dashboard(c *gin.Context) {
	var powerDaily float64 = 0
	var powerCost float64 = 0
	session := sessions.Default(c)
	var deviceD device.Device_dasb
	var now = time.Now() //Get Daily Now
	area := 1
	deviceCard, err := h.userService.DeviceCard(deviceD, area)
	listDevice, err2 := h.userService.ListDevice(area)
	if err != nil || err2 != nil {
		c.HTML(http.StatusInternalServerError, "error_500", nil)
		return
	}
	power, data := h.userService.PowerConDaily(strconv.Itoa(area))
	if power == 0 {
		power = 0
	} else if data == 0 {
		data = 0
	} else {
		powerDaily = power / data
		powerCost = powerDaily * 1352 //Tarif 900 VA
	}
	//fmt.Println(listDevice)
	c.HTML(http.StatusOK, "dashboard", gin.H{
		"title":          "Tamaska Public Lighting Dashboard",
		"UserID":         session.Get("userID"),
		"UserName":       session.Get("userName"),
		"Permission":     session.Get("permission"),
		"deviceActivate": deviceCard.Device_activate,
		"deviceBroken":   deviceCard.Device_broken,
		"deviceTotal":    deviceCard.Device_total,
		"powerDaily":     powerDaily,
		"powerCost":      humanize.Comma(int64(powerCost)),
		"timeUpdate":     fmt.Sprintf("%02d.%02d", now.Hour(), int(now.Minute())),
		"listDevice":     listDevice,
		"timeNow":        fmt.Sprintf(Tanggal(now)),
		"page":           "dashboard",
	})
}

func (h *userView) Register(c *gin.Context) {
	session := sessions.Default(c)
	var now = time.Now() //Get Daily Now
	c.HTML(http.StatusOK, "register", gin.H{
		"title":      "Tamaska Public Lighting Register",
		"UserID":     session.Get("userID"),
		"UserName":   session.Get("userName"),
		"Permission": session.Get("permission"),
		"timeNow":    fmt.Sprintf(Tanggal(now)),
		"page":       "dashboard",
	})
}

func (h *userView) AddUser(c *gin.Context) {
	session := sessions.Default(c)
	var now = time.Now() //Get Daily Now
	listRole, err := h.userService.ListRole(user.ListRole{})
	listArea, err2 := h.userService.ListArea(user.ListArea{})
	if err != nil || err2 != nil {
		c.HTML(http.StatusInternalServerError, "error_500", nil)
		return
	}

	c.HTML(http.StatusOK, "adduser", gin.H{
		"title":      "Tamaska Public Lighting Add User",
		"UserID":     session.Get("userID"),
		"UserName":   session.Get("userName"),
		"Permission": session.Get("permission"),
		"timeNow":    fmt.Sprintf(Tanggal(now)),
		"listRole":   listRole,
		"listArea":   listArea,
		"page":       "dashboard",
	})
}

func (h *userView) ListDeviceLoc(c *gin.Context) {
	session := sessions.Default(c)
	var now = time.Now()
	area := 1
	listDevice, err := h.userService.ListDevice(area)
	if err != nil {
		c.HTML(http.StatusInternalServerError, "error_500", nil)
		return
	}
	c.HTML(http.StatusOK, "listdeviceloc", gin.H{
		"title":      "Daftar Lokasi Device Tamaska Public Lighting",
		"UserID":     session.Get("userID"),
		"UserName":   session.Get("userName"),
		"Permission": session.Get("permission"),
		"listDevice": listDevice,
		"timeNow":    fmt.Sprintf(Tanggal(now)),
		"page":       "listdevicelocation",
	})
}

func (h *userView) ListUser(c *gin.Context) {
	session := sessions.Default(c)
	var now = time.Now() //Get Daily Now
	listUser, err := h.userService.ListUser(user.ListUser{})
	if err != nil {
		c.HTML(http.StatusInternalServerError, "error_500", nil)
		return
	}

	c.HTML(http.StatusOK, "listuser", gin.H{
		"title":      "Tamaska Public Lighting List User",
		"UserID":     session.Get("userID"),
		"UserName":   session.Get("userName"),
		"Permission": session.Get("permission"),
		"listUser":   listUser,
		"timeNow":    fmt.Sprintf(Tanggal(now)),
		"page":       "dashboard",
	})
}

func (h *userView) ListRole(c *gin.Context) {
	session := sessions.Default(c)
	var now = time.Now() //Get Daily Now
	listRole, err := h.userService.ListRole(user.ListRole{})
	if err != nil {
		c.HTML(http.StatusInternalServerError, "error_500", nil)
		return
	}

	c.HTML(http.StatusOK, "listrole", gin.H{
		"title":      "Tamaska Public Lighting List Role",
		"UserID":     session.Get("userID"),
		"UserName":   session.Get("userName"),
		"Permission": session.Get("permission"),
		"listRole":   listRole,
		"timeNow":    fmt.Sprintf(Tanggal(now)),
		"page":       "dashboard",
	})
}

func (h *userView) UpdateUser(c *gin.Context) {
	session := sessions.Default(c)
	var now = time.Now() //Get Daily Now
	listRole, err := h.userService.ListRole(user.ListRole{})
	listArea, err2 := h.userService.ListArea(user.ListArea{})
	idParam := c.Param("user_id")
	user_id, _ := strconv.Atoi(idParam)
	data, err3 := h.userService.GetUserByID(user_id)
	idRole, err4 := h.userService.GetRoleId(user_id)
	idArea, err5 := h.userService.GetAreaId(user_id)

	if err != nil || err2 != nil || err3 != nil || err4 != nil || err5 != nil {
		c.HTML(http.StatusInternalServerError, "error_500", nil)
		return
	}

	c.HTML(http.StatusOK, "edituser", gin.H{
		"title":      "Edit User Form Tamaska Public Lighting",
		"UserID":     session.Get("userID"),
		"UserName":   session.Get("userName"),
		"Permission": session.Get("permission"),
		"listRole":   listRole,
		"listArea":   listArea,
		"nama":       data.Name,
		"email":      data.Email,
		"areaID":     idArea.Division_id,
		"roleID":     idRole.Id,
		"user_id":    user_id,
		"timeNow":    fmt.Sprintf(Tanggal(now)),
		"page":       "dashboard",
	})
}

func (h *userView) Laporan(c *gin.Context) {
	session := sessions.Default(c)
	var now = time.Now()
	userID := session.Get("userID").(int)
	nameArea, err := h.userService.GetArea(userID)
	parsing := device.DeviceCond{}
	nameCond, err2 := h.userService.GetCond(parsing)
	if err != nil || err2 != nil {
		c.HTML(http.StatusInternalServerError, "error_500", nil)
		return
	}

	// Define query search report
	var searchForm device.ReportDeviceUser

	err = c.ShouldBind(&searchForm)
	if err != nil {
		c.Redirect(http.StatusFound, "/public-lighting/report")
		fmt.Print(err)
		return
	}

	resultReport, err := h.userService.UserDeviceReporting(searchForm)
	if err != nil {
		c.Redirect(http.StatusFound, "/public-lighting/report")
		fmt.Print(err)
		return
	}

	c.HTML(http.StatusOK, "laporan", gin.H{
		"title":        "Daftar Lokasi Device Tamaska Public Lighting",
		"UserID":       session.Get("userID"),
		"UserName":     session.Get("userName"),
		"Permission":   session.Get("permission"),
		"timeNow":      fmt.Sprintf(Tanggal(now)),
		"nameArea":     nameArea,
		"nameCond":     nameCond,
		"resultReport": resultReport,
		"page":         "laporan",
	})

}

func (h *userView) Contact(c *gin.Context) {
	session := sessions.Default(c)
	var now = time.Now()

	c.HTML(http.StatusOK, "hubungi_kami", gin.H{
		"title":      "Daftar Lokasi Device Tamaska Public Lighting",
		"UserID":     session.Get("userID"),
		"UserName":   session.Get("userName"),
		"Permission": session.Get("permission"),
		"timeNow":    fmt.Sprintf(Tanggal(now)),
		"page":       "dashboard",
	})

}
