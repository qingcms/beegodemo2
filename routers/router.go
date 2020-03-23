package routers

import (
	"beegodemo/controllers"
	"github.com/astaxie/beego"
)

func init() {
    beego.Router("/", &controllers.MainController{})
	beego.Router("/login", &controllers.LoginController{})
	beego.Router("/logout", &controllers.LoginController{},"get:Logout")
	beego.Router("/index", &controllers.IndexController{})
	beego.Router("/index/:authcode", &controllers.IndexController{})
	beego.Router("/user", &controllers.UserController{})
	beego.Router("/user/ajaxuser", &controllers.UserController{},"post:List")
	beego.Router("/user/add", &controllers.UserController{},"get:Edit")
	beego.Router("/user/edit/:id", &controllers.UserController{},"get:Edit")
	beego.Router("/user/ajaxuserinfo", &controllers.UserController{},"post:Item")
	beego.Router("/role", &controllers.RoleController{})
	beego.Router("/role/ajaxrole", &controllers.RoleController{},"post:List")
	beego.Router("/role/add", &controllers.RoleController{},"get:Edit")
	beego.Router("/role/edit/:id", &controllers.RoleController{},"get:Edit")
	beego.Router("/role/ajaxroleinfo", &controllers.RoleController{},"post:Item")
	beego.Router("/role/roleuser/:id", &controllers.RoleController{},"*:RoleUser")
	beego.Router("/role/roleuser/ajax", &controllers.RoleController{},"*:RoleUser")

	beego.Router("/auth/", &controllers.AuthController{})
/*	beego.Router("/role/add", &controllers.RegisterController{},"get:AddRole")
	beego.Router("/auth/add", &controllers.RegisterController{},"get:AddAuth")
	beego.Router("/user/update", &controllers.RegisterController{},"get:Update")*/
}
