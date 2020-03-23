package controllers

import (
	"beegodemo/controllers/utils"
	"beegodemo/models"
	"github.com/astaxie/beego"
	"strings"
)

type LoginController struct {
	beego.Controller
}

func (this *LoginController) Get() {

	this.TplName = "login.tpl"
}

func (this *LoginController) Post() {

	username := this.GetString("username")
	password := this.GetString("password")

	if username == "" || password == "" {
		this.Data["json"] = beego.M{
			"status": false, "msg": "账号或密码错误1",
		}
	} else {
		var userM, user models.User
		user.UserName = username
		userinfo, err := userM.GetUserInfo(user)
		if err == nil {
			md5password := strings.ToLower(utils.GetMd5String(password))

			if userinfo.PassWord == md5password {
				this.SetSession(AdminUserStateKey+"_id", userinfo.Id)
				this.SetSession(AdminUserStateKey+"_username", userinfo.UserName)
				this.SetSession(AdminUserStateKey+"_name", userinfo.Name)
				this.Data["json"] = beego.M{
					"status": true, "msg": "ok",
				}
			} else {
				this.Data["json"] = beego.M{
					"status": false, "msg": "账号或密码错误2",
				}
			}
		} else {
			this.Data["json"] = beego.M{
				"status": false, "msg": "账号或密码错误3",
			}
		}
	}
	this.ServeJSON()
}

func (this *LoginController) Logout() {

	this.DelSession(AdminUserStateKey + "_id")
	this.DelSession(AdminUserStateKey + "_username")
	this.DelSession(AdminUserStateKey + "_name")
	this.Ctx.Redirect(302, "/login")
}
