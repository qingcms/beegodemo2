package controllers

import (
	"beegodemo/models"
	"github.com/astaxie/beego"
	"strconv"
	"strings"
)

type RoleController struct {
	BaseController
}



func (this *RoleController) Get () {

	this.TplName="role/list.tpl"

}


func  (this *RoleController) List () {
	var roleModel models.Role
	var role models.Role
	rolelist,err :=roleModel.GetRoleList(role)
	if err==nil{
		this.Data["json"]=rolelist
	}else{
		this.Data["json"]=beego.M{"code":false,"errmsg":"操作失败"}
	}
	this.ServeJSON()
	this.StopRun()
}

func (this *RoleController) Edit (){

	this.Data["id"]=this.GetString(":id")
	this.TplName="role/edit.tpl"

}

func  (this *RoleController) Item(){
	roleid,errint :=this.GetInt("id")
	if errint!=nil{
		this.Data["json"]=beego.M{"code":false,"errmsg":"操作失败"}
		this.ServeJSON()
		this.StopRun()
	}

	var roleM,role models.Role
	role.Id=roleid
	roleinfo,err:=roleM.GetRoleInfo(role)

	if err ==nil {
		this.Data["json"]=roleinfo
	}else{
		this.Data["json"]=beego.M{"code":false,"errmsg":"操作失败"}
	}
	this.ServeJSON()
	this.StopRun()
}

func (this *RoleController) Post() {

	var role,roleM models.Role
	role.RoleName = this.GetString("RoleName")
	status,errstatus := this.GetInt("Status")

	if errstatus==nil{
		role.Status=status
	}
	//判断新增还是修改
	action :=this.GetString("Action")
	if action=="add"{
		_,err:=roleM.Add(role)
		if err==nil{
			this.Data["json"]=beego.M{"code":true,"errmsg":"添加成功"}
		}else{
			this.Data["json"]=beego.M{"code":false,"errmsg":"添加操作失败"+err.Error()}
		}
	}else if action=="edit" {
		roleId,errid := this.GetInt("Id")
		if errid !=nil {
			this.Data["json"]=beego.M{"code":false,"errmsg":"操作失败"}
			this.ServeJSON()
			this.StopRun()
		}
		role.Id=roleId
		_,err:=roleM.Update(role)
		if err==nil{
			this.Data["json"]=beego.M{"code":true,"errmsg":"修改成功"}
		}else{
			this.Data["json"]=beego.M{"code":false,"errmsg":"修改操作失败"+err.Error()}
		}
	}else if action=="del" {
		ids:=this.GetString("ids")

		ids=strings.Trim(ids,",")
		if(ids!=""){
			//处理数组，循环删除
			ids_arr:=strings.Split(ids,",")
			for _,id:=range ids_arr{
				idint,err :=strconv.Atoi(id) //string 转int
				if(err==nil){
					roleM.Delete(idint)
				}
			}
			this.Data["json"]=beego.M{"code":true,"errmsg":"删除操作成功"}
		}
	}else{
		this.Data["json"]=beego.M{"code":false,"errmsg":"操作异常"}
	}
	this.ServeJSON()
	this.StopRun()
}


func (this *RoleController) RoleUser() {

	id:=this.GetString(":id")
	if(id!=""){
		this.Data["roleid"]=id
		this.TplName="role/userlist.tpl"
		this.StopRun()
	}
}

