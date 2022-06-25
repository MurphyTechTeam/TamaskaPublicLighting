package user

type LoginInput struct {
	Email    string `json:"email" form:"email" binding:"required,email"`
	Password string `json:"password" form:"password" binding:"required"`
}
type RegisterInput struct {
	Nama     string `json:"nama" form:"nama" binding:"required"`
	Email    string `json:"email" form:"email" binding:"required,email"`
	Password string `json:"password" form:"password" binding:"required"`
	Role     string `json:"role" form:"role"`
	Area     string `json:"area" form:"area"`
	// Role1   string `json:"role1" form:"role1"`
	// Role2   string `json:"role2" form:"role2"`
	// Role3   string `json:"role3" form:"role3"`
	// Role4   string `json:"role4" form:"role4"`
}
type RoleInput struct {
	User_id int
	Role_id int
}
type AreaInput struct {
	User_id int
	Area_id int
}
type UpdateUser struct {
	User_id      int    `json:"user_id" form:"user_id" binding:"required"`
	Nama         string `json:"nama" form:"nama" binding:"required"`
	Email        string `json:"email" form:"email" binding:"required,email"`
	Password     string `json:"password" form:"password" binding:"required"`
	Role         string `json:"role" form:"role"`
	Area         string `json:"area" form:"area"`
	Id_user_role string `json:"id_user_role" form:"id_user_role"`
	Id_user_area string `json:"id_user_area" form:"id_user_area"`
	// Role1   string `json:"role1" form:"role1"`
	// Role2   string `json:"role2" form:"role2"`
	// Role3   string `json:"role3" form:"role3"`
	// Role4   string `json:"role4" form:"role4"`
}
type UpdateRole struct {
	User_id int
	Role_id int
}
type UpdateArea struct {
	User_id int
	Area_id int
}
