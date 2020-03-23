package controllers

import (
	"beegodemo/controllers/utils"
	"beegodemo/models"
	"github.com/astaxie/beego"
	"strconv"
	"strings"
)

type UserController struct {
	BaseController
}

func (this *UserController) Get() {
	this.TplName = "user/list.tpl"
}

func (this *UserController) List() {
	var userModel models.User
	var user models.User
	userlist, err := userModel.GetUserList(user)
	if err == nil {
		this.Data["json"] = userlist
	} else {
		this.Data["json"] = beego.M{"code": false, "errmsg": "操作失败"}
	}
	this.ServeJSON()
	this.StopRun()
}

func (this *UserController) Edit() {

	this.Data["id"] = this.GetString(":id")
	this.TplName = "user/edit.tpl"

}

func (this *UserController) Item() {
	userid, errint := this.GetInt("id")
	if errint != nil {
		this.Data["json"] = beego.M{"code": false, "errmsg": "操作失败"}
		this.ServeJSON()
		this.StopRun()
	}
	var userM, user models.User
	user.Id = userid
	userinfo, err := userM.GetUserInfo(user)
	userinfo.PassWord = ""
	if err == nil {
		this.Data["json"] = userinfo
	} else {
		this.Data["json"] = beego.M{"code": false, "errmsg": "操作失败"}
	}
	this.ServeJSON()
	this.StopRun()
}

func (this *UserController) Post() {

	var user, userM models.User
	user.UserName = this.GetString("UserName")
	user.Name = this.GetString("Name")
	status, errstatus := this.GetInt("Status")
	user.Mobile = this.GetString("Mobile")
	user.Email = this.GetString("Email")

	if errstatus == nil {
		user.Status = status
	}
	//判断新增还是修改
	action := this.GetString("Action")
	if action == "add" {
		user.PassWord = utils.GetMd5String("123456")
		_, err := userM.Add(user)
		if err == nil {
			this.Data["json"] = beego.M{"code": true, "errmsg": "添加成功"}
		} else {
			this.Data["json"] = beego.M{"code": false, "errmsg": "添加操作失败" + err.Error()}
		}
	} else if action == "edit" {
		userId, errid := this.GetInt("Id")
		if errid != nil {
			this.Data["json"] = beego.M{"code": false, "errmsg": "操作失败"}
			this.ServeJSON()
			this.StopRun()
		}
		user.Id = userId
		_, err := userM.Update(user)
		if err == nil {
			this.Data["json"] = beego.M{"code": true, "errmsg": "修改成功"}
		} else {
			this.Data["json"] = beego.M{"code": false, "errmsg": "修改操作失败" + err.Error()}
		}
	} else if action == "del" {
		ids := this.GetString("ids")

		ids = strings.Trim(ids, ",")
		if ids != "" {
			//处理数组，循环删除
			ids_arr := strings.Split(ids, ",")
			for _, id := range ids_arr {
				idint, err := strconv.Atoi(id) //string 转int
				if err == nil {
					userM.Delete(idint)
				}
			}
			this.Data["json"] = beego.M{"code": true, "errmsg": "删除操作成功"}
		}
	} else {
		this.Data["json"] = beego.M{"code": false, "errmsg": "操作异常"}
	}
	this.ServeJSON()
	this.StopRun()
}
