package routes

import (
	"TamaskaPublicLighting/app/auth"
	"TamaskaPublicLighting/app/middlewares"
	"TamaskaPublicLighting/module/handler"
	"TamaskaPublicLighting/module/utilities/device"
	"TamaskaPublicLighting/module/utilities/user"
	"TamaskaPublicLighting/module/view"

	"github.com/gin-contrib/cors"
	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/cookie"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func Init(db *gorm.DB) *gin.Engine {
	gin.SetMode(gin.ReleaseMode)
	authService := auth.NewService()
	// Load Repository
	userRepository := user.NewRepository(db)
	deviceRepository := device.NewRepository(db)
	//Load Service
	userService := user.NewService(userRepository)
	deviceService := device.NewService(deviceRepository)
	//Load Handler
	userHandler := handler.NewUserHandler(userService, authService)
	deviceHandler := handler.NewDeviceHandler(deviceService)
	//Load View
	userView := view.NewUserView(userService)
	deviceView := view.NewDeviceView(deviceService)

	router := gin.Default()
	router.Use(cors.Default())

	cookieStore := cookie.NewStore([]byte(auth.SECRET_KEY))
	router.Use(sessions.Sessions("tamaskapubliclighting", cookieStore))
	router.HTMLRender = middlewares.ManualRender("./public/template/")

	// Routing Website Service
	router.NoRoute(gin.BasicAuth(gin.Accounts{
		auth.AuthUser: auth.AuthPassword,
	}), func(c *gin.Context) {
		c.HTML(404, "error_404", nil)
	})

	general := router.Group("/", gin.BasicAuth(gin.Accounts{
		auth.AuthUser: auth.AuthPassword,
	}))

	//Routing General Tamaska Component
	general.GET("/", userView.Login)
	general.GET("/login", userView.Login)
	general.POST("/login", userHandler.Login)
	general.GET("/logout", userHandler.Logout)
	// general.GET("/register", userView.Register)
	// general.POST("/register", userHandler.Register)

	//Routing User Management Tamaska
	general.GET("/add-user", userView.AddUser)
	general.POST("/add-user", userHandler.AddUser)
	general.GET("/edit-user/:user_id", userView.UpdateUser)
	general.POST("/edit-user/:user_id", userHandler.UpdateUser)
	general.GET("/delete-user/:user_id", userHandler.DeleteUser)
	general.GET("/list-user", userView.ListUser)
	general.GET("/list-role", userView.ListRole)

	//Routing Tamaska Public Lighting Component URL
	pju := router.Group("/public-lighting", gin.BasicAuth(gin.Accounts{
		auth.AuthUser: auth.AuthPassword,
	}))
	pju.GET("/dashboard", middlewares.AuthDashboard(), userView.Dashboard)
	pju.GET("/add", deviceView.AddDevice)
	pju.POST("/add", deviceHandler.AddDevice)
	pju.GET("/list", userView.ListDeviceLoc)
	pju.GET("/:id", deviceView.DetailDevice)
	pju.GET("/edit/:id_device", deviceView.EditDevice)
	pju.POST("/edit", deviceHandler.EditDevice)
	pju.GET("/delete/:id", deviceHandler.DeleteDevice)
	pju.GET("/control/:device/:power", deviceHandler.ManualControl)
	pju.GET("/brightness/:id/:device/:brightness", deviceHandler.BrightnessControl)
	pju.GET("/report", middlewares.AuthDashboard(), userView.Laporan)
	pju.GET("/contact-us", userView.Contact)
	// pju.POST("/report", userHandler.UserDeviceReport)
	pju.POST("/report", userView.Laporan)
	//router.GET("/listdeviceantares", deviceView.ListDevice)

	//Routing Tamaska API Service
	api := router.Group("/public-lighting/api/v1")
	api.POST("/powerconsumption", middlewares.AuthAPI(authService, userService), deviceHandler.PowerConsumption)
	api.GET("/maps", middlewares.AuthAPI(authService, userService), deviceHandler.MapsAllDevice)
	api.POST("/maps", middlewares.AuthAPI(authService, userService), deviceHandler.MapsDeviceByID)
	api.POST("/webhook", middlewares.AuthAPI(authService, userService), deviceHandler.WebhookHandler)

	return router
}
