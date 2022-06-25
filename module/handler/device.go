package handler

import (
	"TamaskaPublicLighting/app/helper"
	"TamaskaPublicLighting/module/utilities/device"
	"fmt"
	"net/http"
	"strconv"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
)

type DeviceHandler interface {
	ManualControl(c *gin.Context)
	AddDevice(c *gin.Context)
	EditDevice(c *gin.Context)
	DeleteDevice(c *gin.Context)
	WebhookHandler(c *gin.Context)
	PowerConsumption(c *gin.Context)
	MapsAllDevice(c *gin.Context)
	MapsDeviceByID(c *gin.Context)
	BrightnessControl(c *gin.Context)
}

type deviceHandler struct {
	deviceService device.Service
}

func NewDeviceHandler(deviceService device.Service) *deviceHandler {
	return &deviceHandler{deviceService}
}

func (h *deviceHandler) ManualControl(c *gin.Context) {
	sessions := sessions.Default(c)
	//http://localhost:9001/devicecontrol/Luminer/1
	device := c.Param("device")
	power := "000" + c.Param("power")

	control, err := h.deviceService.ManualControl(power, device)
	if err != nil {
		fmt.Println(err)
		c.HTML(http.StatusInternalServerError, "error_500", nil)
		return
	}

	if control == 1 {
		if power == "0001" {
			sessions.AddFlash("Device " + device + " Menyala")
		} else if power == "0000" {
			sessions.AddFlash("Device " + device + " Mati")
		} else {
			sessions.AddFlash("Kesalahan! Tidak ada respon dari device")
		}
	} else {
		sessions.AddFlash("Kesalahan! Tidak ada respon dari device")
	}
	c.Redirect(http.StatusFound, "/public-lighting/list")
}

func (h *deviceHandler) AddDevice(c *gin.Context) {
	var deviceform device.AddDeviceInput

	err := c.ShouldBind(&deviceform)
	if err != nil {
		c.Redirect(http.StatusFound, "/public-lighting/add")
		fmt.Print(err)
		return
	}

	_, _, _, err = h.deviceService.AddingDevice(deviceform)
	if err != nil {
		c.Redirect(http.StatusFound, "/public-lighting/add")
		fmt.Print(err)
		return
	}
	fmt.Println("Sukses Tambah Device")
	c.Redirect(http.StatusFound, "/public-lighting/list")
}

func (h *deviceHandler) EditDevice(c *gin.Context) {
	//http://localhost:9001/editdevice/1

	var editform device.UpdateDevice

	err := c.ShouldBind(&editform)
	if err != nil {

		c.Redirect(http.StatusFound, "/public-lighting/edit")
		fmt.Print(err)
		return
	}

	_, err = h.deviceService.EditingDevice(editform)
	if err != nil {
		c.Redirect(http.StatusFound, "/public-lighting/edit")
		fmt.Print(err)
		return
	}

	fmt.Println("Sukses Update Data Device")
}

func (h *deviceHandler) DeleteDevice(c *gin.Context) {
	sessions := sessions.Default(c)

	idParam := c.Param("id")
	id, _ := strconv.Atoi(idParam)

	delete, err := h.deviceService.DeleteDevice(id)
	if err != nil {
		fmt.Println(err)
		c.HTML(http.StatusInternalServerError, "error_500", nil)
		return
	}
	if delete == 1 {
		sessions.AddFlash("sukseshapusdevice")
	} else {
		sessions.AddFlash("gagalhapusdevice")
	}
	fmt.Println("Sukses Delete Device")
	c.Redirect(http.StatusFound, "/public-lighting/list")
}

func (h *deviceHandler) WebhookHandler(c *gin.Context) {
	var scnhubInput device.DeviceHistory
	if err := c.ShouldBindJSON(&scnhubInput); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	_, err := h.deviceService.BindWhData(scnhubInput)
	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println("Sukses menerima data dari WebHook")
	c.JSON(http.StatusCreated, gin.H{
		"message": "Webhook posted into Database",
		"data":    scnhubInput,
	})
}

func (h *deviceHandler) PowerConsumption(c *gin.Context) {
	var input device.IdDeviceHistory

	err := c.ShouldBindJSON(&input)
	if err != nil {
		response := helper.APIRespon("Failed to get Power Consumption, Invalid Input", 215, "error", nil)
		c.JSON(http.StatusBadRequest, response)
		return
	}
	area := 1
	powerCon, err := h.deviceService.PowerConsumption(area, input) //db energy
	if err != nil {
		response := helper.APIRespon("Failed to get Power Consumption", 210, "error", nil)
		c.JSON(http.StatusBadRequest, response)
		return
	} else if powerCon == nil {
		response := helper.APIRespon("Failed to get Power Consumption, Can't find device", 220, "error", nil)
		c.JSON(http.StatusBadRequest, response)
		return
	}
	response := helper.APIRespon("Success to get Power Consumption", http.StatusOK, "success", powerCon)
	c.JSON(http.StatusOK, response)
}
func (h *deviceHandler) MapsAllDevice(c *gin.Context) {
	area := 1
	allDevice, err := h.deviceService.AllCoordinate(area)
	if err != nil {
		response := helper.APIRespon("Failed to get Coordinate Device", 210, "error", nil)
		c.JSON(http.StatusBadRequest, response)
		return
	} else if allDevice == nil {
		response := helper.APIRespon("Failed to get Coordinat Device", 210, "error", nil)
		c.JSON(http.StatusBadRequest, response)
		return
	}
	response := helper.APIRespon("Success to get Coordinate Device", http.StatusOK, "success", allDevice)
	c.JSON(http.StatusOK, response)
}

func (h *deviceHandler) MapsDeviceByID(c *gin.Context) {
	area := 1
	var input device.IdDeviceHistory

	err := c.ShouldBindJSON(&input)
	if err != nil {
		response := helper.APIRespon("Failed to get Coordinate Device, Invalid Input", 215, "error", nil)
		c.JSON(http.StatusBadRequest, response)
		return
	}

	Device, err := h.deviceService.CoordinateByID(area, input.Device_id)
	if err != nil {
		response := helper.APIRespon("Failed to get Coordinate Device", 210, "error", nil)
		c.JSON(http.StatusBadRequest, response)
		return
	} else if Device == nil {
		response := helper.APIRespon("Failed to get Coordinat Device", 210, "error", nil)
		c.JSON(http.StatusBadRequest, response)
		return
	}
	response := helper.APIRespon("Success to get Coordinate Device", http.StatusOK, "success", Device)
	c.JSON(http.StatusOK, response)
}

func (h *deviceHandler) BrightnessControl(c *gin.Context) {
	sessions := sessions.Default(c)
	//http://localhost:9001/brightnesscontrol/1/Luminer/brightness(50)
	id := c.Param("id")
	device := c.Param("device")
	bright := c.Param("brightness")
	brightness, _ := strconv.Atoi(bright)

	control, err := h.deviceService.BrightnessControl(brightness, device)
	if err != nil {
		fmt.Println(err)
		c.HTML(http.StatusInternalServerError, "error_500", nil)
		return
	}

	if control == 1 {
		sessions.AddFlash("Berhasil merupabah kecerahan device")
	} else {
		sessions.AddFlash("Kesalahan! Tidak ada respon dari device")
	}
	c.Redirect(http.StatusFound, "/public-lighting/"+id)
}
