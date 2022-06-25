package handler

import (
	"TamaskaPublicLighting/app/auth"
	"TamaskaPublicLighting/module/utilities/user"
	"fmt"
	"log"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
)

type UserHandler interface {
	Login(c *gin.Context)
	Logout(c *gin.Context)
	Register(c *gin.Context)
	DeleteUser(c *gin.Context)
	UpdateUser(c *gin.Context)
}

type userHandler struct {
	userService user.Service
	authService auth.Service
}

func NewUserHandler(userService user.Service, authService auth.Service) *userHandler {
	return &userHandler{userService, authService}
}

func (h *userHandler) Login(c *gin.Context) {
	session := sessions.Default(c)
	var input user.LoginInput
	err := c.ShouldBind(&input)
	if err != nil {
		log.Println(err) //Print log error
		session.AddFlash("Invalid email format")
		c.HTML(http.StatusOK, "login", gin.H{
			"title":   "Tamaska Public Lighting Login",
			"flashes": session.Flashes(),
		})
		return
	}

	user, err := h.userService.Login(input)
	if err != nil {
		log.Println(err)                                //Print log error
		session.AddFlash("Username/Password is wrong!") //Send Notification Eror in FE
		c.HTML(http.StatusOK, "login", gin.H{
			"title":   "Tamaska Public Lighting Login",
			"flashes": session.Flashes(),
		})
		return
	}
	//Get Roles User
	role, err := h.userService.GetRoles(user.User_id)
	if err != nil {
		log.Println(err) //Cetak log error
		c.Redirect(http.StatusFound, "/login")
		return
	}
	permission := []string{"0", "0", "0", "0"}
	for i := 0; i <= 4; i++ { //Create Permission by Roles
		for _, v := range role {
			if i+1 == v.Role_id {
				permission[i] = "1"
			}
		}
	}
	//Generate JWT Token (Please Uncomment for Generate Token)
	// token, err := h.authService.GenerateToken(user.User_id)
	// if err != nil {
	// 	log.Println(err) //Cetak log error
	// 	return
	// }
	// fmt.Println("JWT Token: " + token)

	//Create Session Login
	session.Set("userID", user.User_id)
	session.Set("userName", user.Name)
	session.Set("permission", strings.Join(permission, "tmk"))
	session.Save()

	c.Redirect(http.StatusFound, "/public-lighting/dashboard")
}

func (h *userHandler) Logout(c *gin.Context) {
	session := sessions.Default(c)
	session.Clear()
	session.Save()

	c.Redirect(http.StatusFound, "/login")
}

func (h *userHandler) Register(c *gin.Context) {
	var input2 user.RegisterInput

	err := c.ShouldBind(&input2)
	if err != nil {
		c.Redirect(http.StatusFound, "/register")
		fmt.Print(err)
		return
	}

	_, _, _, err = h.userService.RegisterUser(input2)
	if err != nil {
		c.Redirect(http.StatusFound, "/register")
		fmt.Print(err)
		return
	}
	fmt.Println("Sukses Register")
	c.Redirect(http.StatusFound, "/login")
}

func (h *userHandler) AddUser(c *gin.Context) {
	var input2 user.RegisterInput

	err := c.ShouldBind(&input2)
	if err != nil {
		c.Redirect(http.StatusFound, "/add-user")
		fmt.Print(err)
		return
	}

	_, _, _, err = h.userService.RegisterUser(input2)
	if err != nil {
		c.Redirect(http.StatusFound, "/add-user")
		fmt.Print(err)
		return
	}
	fmt.Println("Sukses Register")
	c.Redirect(http.StatusFound, "/list-user")
}

func (h *userHandler) UpdateUser(c *gin.Context) {
	var editform user.UpdateUser

	err := c.ShouldBind(&editform)
	if err != nil {

		c.Redirect(http.StatusFound, "/edit-user")
		fmt.Print(err)
		return
	}

	_, err = h.userService.UpdateUser(editform)
	if err != nil {
		c.Redirect(http.StatusFound, "/edit-user")
		fmt.Print(err)
		return
	}

	fmt.Println("Sukses Update Data User")
	c.Redirect(http.StatusFound, "/list-user")
}

func (h *userHandler) DeleteUser(c *gin.Context) {
	sessions := sessions.Default(c)

	idParam := c.Param("user_id")
	user_id, _ := strconv.Atoi(idParam)

	delete, err := h.userService.DeleteUser(user_id)
	if err != nil {
		fmt.Println(err)
		c.HTML(http.StatusInternalServerError, "error_500", nil)
		return
	}
	if delete == 1 {
		sessions.AddFlash("sukseshapususer")
	} else {
		sessions.AddFlash("gagalhapususer")
	}
	fmt.Println("Sukses Delete User")
	c.Redirect(http.StatusFound, "/list-user")
}
