package middlewares

import (
	"TamaskaPublicLighting/app/auth"
	"TamaskaPublicLighting/app/helper"
	"TamaskaPublicLighting/module/utilities/user"
	"net/http"
	"strings"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-contrib/multitemplate"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
)

func ManualRender(tmpDir string) multitemplate.Renderer {
	r := multitemplate.NewRenderer()
	r.AddFromFiles("login", tmpDir+"home/home_login.html", tmpDir+"layouts/header.html", tmpDir+"layouts/footer.html")
	r.AddFromFiles("dashboard", tmpDir+"home/home_dashboard.html", tmpDir+"layouts/header.html", tmpDir+"layouts/menu.html", tmpDir+"layouts/navbar.html", tmpDir+"layouts/overlay.html", tmpDir+"layouts/footer.html")
	r.AddFromFiles("listdeviceloc", tmpDir+"device/listloc_device.html", tmpDir+"layouts/header.html", tmpDir+"layouts/menu.html", tmpDir+"layouts/navbar.html", tmpDir+"layouts/overlay.html", tmpDir+"layouts/footer.html")
	r.AddFromFiles("listuser", tmpDir+"home/home_list_user.html", tmpDir+"layouts/header.html", tmpDir+"layouts/menu.html", tmpDir+"layouts/navbar.html", tmpDir+"layouts/overlay.html", tmpDir+"layouts/footer.html")
	r.AddFromFiles("adduser", tmpDir+"home/home_add_user.html", tmpDir+"layouts/header.html", tmpDir+"layouts/menu.html", tmpDir+"layouts/navbar.html", tmpDir+"layouts/overlay.html", tmpDir+"layouts/footer.html")
	r.AddFromFiles("edituser", tmpDir+"home/home_edit_user.html", tmpDir+"layouts/header.html", tmpDir+"layouts/menu.html", tmpDir+"layouts/navbar.html", tmpDir+"layouts/overlay.html", tmpDir+"layouts/footer.html")

	r.AddFromFiles("hubungi_kami", tmpDir+"home/home_contact.html", tmpDir+"layouts/header.html", tmpDir+"layouts/menu.html", tmpDir+"layouts/navbar.html", tmpDir+"layouts/overlay.html", tmpDir+"layouts/footer.html")

	r.AddFromFiles("listrole", tmpDir+"home/home_list_role.html", tmpDir+"layouts/header.html", tmpDir+"layouts/menu.html", tmpDir+"layouts/navbar.html", tmpDir+"layouts/overlay.html", tmpDir+"layouts/footer.html")
	r.AddFromFiles("laporan", tmpDir+"device/laporan.html", tmpDir+"layouts/header.html", tmpDir+"layouts/menu.html", tmpDir+"layouts/navbar.html", tmpDir+"layouts/overlay.html", tmpDir+"layouts/footer.html")

	//r.AddFromFiles("register", tmpDir+"home/home_regist.html")
	r.AddFromFiles("listdevice", tmpDir+"device/device_list.html")
	r.AddFromFiles("detaildevice", tmpDir+"device/device_detail.html")
	//r.AddFromFiles("adddevice", tmpDir+"device/add_device.html")
	//r.AddFromFiles("editdevice", tmpDir+"device/edit_device.html")
	r.AddFromFiles("editdevice", tmpDir+"device/edit_device.html", tmpDir+"layouts/header.html", tmpDir+"layouts/menu.html", tmpDir+"layouts/navbar.html", tmpDir+"layouts/overlay.html", tmpDir+"layouts/footer.html")
	r.AddFromFiles("adddevice", tmpDir+"device/add_device.html", tmpDir+"layouts/header.html", tmpDir+"layouts/menu.html", tmpDir+"layouts/navbar.html", tmpDir+"layouts/overlay.html", tmpDir+"layouts/footer.html")

	//Error Handling Page and Routes
	r.AddFromFiles("error_404", tmpDir+"common/error_404.html", tmpDir+"layouts/header.html", tmpDir+"layouts/footer.html")
	r.AddFromFiles("error_500", tmpDir+"common/error_500.html", tmpDir+"layouts/header.html", tmpDir+"layouts/footer.html")
	r.AddFromFiles("error_400", tmpDir+"common/error_400.html", tmpDir+"layouts/header.html", tmpDir+"layouts/footer.html")
	return r
}

func AuthDashboard() gin.HandlerFunc {
	return func(c *gin.Context) {
		session := sessions.Default(c)
		userIDSession := session.Get("userID")
		if userIDSession == nil {
			c.Redirect(http.StatusFound, "/login")
			return
		}
	}
}

func AuthAPI(authService auth.Service, userService user.Service) gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.Request.Header.Get("Authorization")

		if !strings.Contains(authHeader, "Bearer") {
			response := helper.APIRespon("Unauthorized", http.StatusUnauthorized, "error", nil)
			c.AbortWithStatusJSON(http.StatusUnauthorized, response)
			return
		}

		tokenString := ""
		arrayToken := strings.Split(authHeader, " ")
		if len(arrayToken) == 2 {
			tokenString = arrayToken[1]
		}

		token, err := authService.ValidateToken(tokenString)
		if err != nil {
			response := helper.APIRespon("Unauthorized", http.StatusUnauthorized, "error", nil)
			c.AbortWithStatusJSON(http.StatusUnauthorized, response)
			return
		}

		claim, ok := token.Claims.(jwt.MapClaims)

		if !ok || !token.Valid {
			response := helper.APIRespon("Unauthorized", http.StatusUnauthorized, "error", nil)
			c.AbortWithStatusJSON(http.StatusUnauthorized, response)
			return
		}

		userID := int(claim["user_id"].(float64))

		user, err := userService.GetUserByID(userID) //Get User by ID
		if err != nil {
			response := helper.APIRespon("Unauthorized", http.StatusUnauthorized, "error", nil)
			c.AbortWithStatusJSON(http.StatusUnauthorized, response)
			return
		}

		c.Set("currentUser", user) //Set currentUser API
	}
}
