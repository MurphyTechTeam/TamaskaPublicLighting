package view

import (
	"TamaskaPublicLighting/module/utilities/device"
	"fmt"
	"net/http"
	"time"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
)

type deviceView struct {
	deviceService device.Service
}

func NewDeviceView(deviceService device.Service) *deviceView {
	return &deviceView{deviceService}
}

func (dv *deviceView) ListDevice(c *gin.Context) {
	//session := sessions.Default(c)
	device, err := dv.deviceService.GetAllDevice()
	if err != nil {
		c.HTML(http.StatusInternalServerError, "error_500", nil)
		return
	}
	//fmt.Println(device)
	c.HTML(http.StatusOK, "listdevice", gin.H{
		"title": "List Device Tamaska Public Lighting",
		//"UserName": session.Get("userName"),
		"device": device,
	})
}

func (h *deviceView) AddDevice(c *gin.Context) {
	session := sessions.Default(c)
	var now = time.Now()
	c.HTML(http.StatusOK, "adddevice", gin.H{
		"title":      "Add Device Form Tamaska Public Lighting",
		"UserName":   session.Get("userName"),
		"Permission": session.Get("permission"),
		"timeNow":    fmt.Sprintf(Tanggal(now)),
		"page":       "listdevicelocation",
	})
}

func (h *deviceView) EditDevice(c *gin.Context) {
	session := sessions.Default(c)
	var now = time.Now()
	id_device := c.Param("id_device")

	c.HTML(http.StatusOK, "editdevice", gin.H{
		"title":      "Edit Device Form Tamaska Public Lighting",
		"id_device":  id_device,
		"UserName":   session.Get("userName"),
		"Permission": session.Get("permission"),
		"timeNow":    fmt.Sprintf(Tanggal(now)),
		"page":       "listdevicelocation",
	})
}
func (h *deviceView) DetailDevice(c *gin.Context) {
	c.HTML(http.StatusOK, "detaildevice", gin.H{
		"title": "Detail Device Tamaska Public Lighting"})
}
