package controllers

import (
	"beegodemo/models"
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"strings"
)

const AdminUserStateKey = "admin_userstate_key"

type BaseController struct {
	beego.Controller
}

//所有方法前置 执行获取GetUserState
func (this *BaseController) Prepare() {
	this.GetUserState()
}

//获取用户信息
func (this *BaseController) GetUserState() {
	//获取当前session信息
	id := this.GetSession(AdminUserStateKey + "_id")
	name := this.GetSession(AdminUserStateKey + "_name")
	username := this.GetSession(AdminUserStateKey + "_username")
	//调用验证权限方法
	this.CheckUserAuth()
	//当前session
	if id == nil || name == nil || username == nil {
		this.Ctx.Redirect(302, "/login")
	}
	userinfo := models.User{UserName: username.(string), Id: id.(int), Name: name.(string)}
	this.Data["userinfo"] = userinfo
}

//验证权限
func (this *BaseController) CheckUserAuth() {

	//设置公共不拦截页面
	publicUrlData := []string{
		"/index",
		"/login",
	}

	//读取当前页面url
	selfURI := this.Ctx.Request.RequestURI
	//获取用户权限列表
	userauthlist, authids := this.GetAuthList()

	//循环当前用户权限，判断用户是否具有权限
	var isAuth bool
	isAuth = false

	for _, rowPublicAuth := range publicUrlData {
		if strings.Contains("*"+selfURI, "*"+fmt.Sprint(rowPublicAuth)) {
			isAuth = true
			break
		}
	}

	if isAuth == false {
		for _, rowUserAuth := range userauthlist {
			//判断为空本次不执行，循环下一次
			if rowUserAuth[5] == nil {
				continue
			}
			//判断系统字符串是否包含当前url
			if strings.Contains("*"+selfURI, "*"+fmt.Sprint(rowUserAuth[5])) {
				isAuth = true
				break
			}
		}
	}
	//没有权限
	if isAuth == false {
		this.Ctx.Redirect(504, "/login")
	}
	//执行获取菜单列表
	this.GetMenuList(authids)

}

/*
 *获取用户权限列表
 */
func (this *BaseController) GetAuthList() ([]orm.ParamsList, []string) {

	userid := this.GetSession(AdminUserStateKey + "_id")
	if userid == nil {
		this.Ctx.Redirect(302, "/login")
	}
	//根据userid查询角色Id
	//查询角色数据库
	var roleUser models.RoleUser
	rolelist, err := roleUser.GetRoleUserList(userid.(int))
	if err != nil {
		this.Ctx.Redirect(504, "/login")
	}
	//循环角色
	var roleids []string
	//获取角色Id
	for _, rowRoleUser := range rolelist {
		roleids = append(roleids, fmt.Sprint(rowRoleUser[0]))
	}

	//根据角色获取权限ID
	var roleAuth models.RoleAuth
	roleauthlist, err := roleAuth.GetRoleUserList(roleids)

	if err != nil {
		this.Ctx.Redirect(504, "/login")
	}
	var authids []string
	for _, rowRoleAuth := range roleauthlist {
		authids = append(authids, fmt.Sprint(rowRoleAuth[0]))
	}
	//获取有效的用户权限列表
	var auth models.Auth
	userauthlist, err := auth.GetAuthList(authids)

	if err != nil {
		this.Ctx.Redirect(504, "/login")
	}

	return userauthlist, authids
}

func (this *BaseController) GetMenuList(authids []string) {

	//读取顶级菜单code
	pauthcode := this.GetString(":authcode")

	//判断为空时 设置默认读取系统管理
	if pauthcode == "" {
		pauthcode = "sys"
	}
	parentPath := "root." + pauthcode
	//获取权限顶级目录列表
	var auth models.Auth
	userTopMenulist, err := auth.GetAuthMapList(authids, 1, "")
	if err != nil {
		this.Ctx.Redirect(504, "/login")
	}
	for topline, rowTopMenu := range userTopMenulist {
		if fmt.Sprint(rowTopMenu["AuthCode"]) == pauthcode {
			userTopMenulist[topline]["active"] = "active"
		}
	}
	//传递到模板
	this.Data["TopMenu"] = userTopMenulist

	//获取左边菜单权限
	leftMenuList, err := auth.GetAuthMapList(authids, 0, string(parentPath))
	if err != nil {
		this.Ctx.Redirect(504, "/login")
	}

	var treeAuthList []orm.Params
	//左边菜单 第一层
	for _, rowUserAuth := range leftMenuList {
		parentPath2 := rowUserAuth["ParentPath"]
		if parentPath2 == parentPath {
			rowUserAuth["SubList"] = nil
			treeAuthList = append(treeAuthList, rowUserAuth)
		}
	}
	//左边菜单第二层
	var treeSubAuthList []orm.Params
	var isSubCount int
	for lineone, rowOneUserAuth := range treeAuthList {
		authcode := fmt.Sprint(rowOneUserAuth["AuthCode"])
		parentPath = "root." + pauthcode + "." + authcode
		treeSubAuthList = nil
		isSubCount = 0
		for _, rowTwoUserAuth := range leftMenuList {
			parentPath2 := rowTwoUserAuth["ParentPath"]
			if parentPath2 == parentPath {
				isSubCount++
				treeSubAuthList = append(treeSubAuthList, rowTwoUserAuth)
			}
		}
		treeAuthList[lineone]["isSubCount"] = isSubCount
		treeAuthList[lineone]["SubList"] = treeSubAuthList
	}
	//传递到模板
	this.Data["TopAuthCode"] = string(pauthcode)
	this.Data["LeftMenu"] = treeAuthList
}
