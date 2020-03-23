package models

import (
	"errors"
	"fmt"
	"github.com/astaxie/beego/orm"
	"time"
)
//角色表
type Role struct {
	Id int
	RoleName string
	Status int
	CreateUser string
	CreateTime time.Time
	UpdateTime time.Time
}
//角色用户表
type RoleUser struct {
	Id int
	RoleId int
	UserId int
}
//角色权限表
type RoleAuth struct {
	Id int
	RoleId int
	AuthId int
}


func (this *Role) GetRoleInfo(role Role) (Role,error) {
	o :=orm.NewOrm()
	var rolem Role
	var errr error
	rolem =Role{Id: role.Id}
	errr =o.Read(&rolem)

	if errr == orm.ErrNoRows {
		return rolem, errors.New("No User Data")
	} else if errr == orm.ErrMissPK {
		return rolem , errors.New("No User Data")
	} else {
		return rolem,nil
	}

	return rolem, errors.New("No User Data")
}

/**
 *添加用户数据
 */
func (this *Role) Add(role Role) (int64 , error ){
	o :=orm.NewOrm()

	oRole :=new(Role)
	oRole.RoleName=role.RoleName
	oRole.Status=role.Status
	oRole.CreateUser="admin"
	oRole.CreateTime=time.Now()
	result,err :=o.Insert(oRole)
	fmt.Println(oRole)
	if err==nil{
		return result,nil
	}
	return  0,err
}
/**
 * 更新角色数据
 */
func (this *Role) Update(role Role) (int64 , error ){
	o :=orm.NewOrm()
	oRole :=Role{Id:role.Id}
	err :=o.Read(&oRole)
	if  err==nil {
		oRole.RoleName=role.RoleName
		oRole.Status=role.Status
		oRole.UpdateTime=time.Now()
		num,err :=o.Update(&oRole);
		if err==nil{
			return num,nil
		}
		return  0,err
	}else{
		return  0,err
	}
}
/**
  删除角色
 */
func (this *Role) Delete(id int)(int64, error){
	o :=orm.NewOrm()
	oRole :=Role{Id:id}
	num, err := o.Delete(&oRole)
	if  err == nil {
		return  num,nil
	}
	return 0,err



}

/**
 * 获取所有角色列表
 */
func (this *Role) GetRoleList(role Role) ([] orm.Params, error){
	//根据roleid查询角色
	o :=orm.NewOrm()
	rsrole :=o.QueryTable(new(Role))

	if role.RoleName !=""{
		rsrole.Filter("RoleName__icontains",role.RoleName)
	}

	if role.Status >=-1 {
		rsrole.Filter("Status",role.Status)
	}
	var rolelist [] orm.Params
	_,err :=rsrole.Values(&rolelist)
	if err !=nil {
		return nil,err
	}
	return rolelist,nil
}


/**
 *根据用户获取，用户所有角色列表
 */
func (this *RoleUser) GetRoleUserList(userid int ) ([] orm.ParamsList, error){
	//根据userid查询角色Id
	o :=orm.NewOrm()
	rsuser :=o.QueryTable(new(RoleUser))
	var rolelist [] orm.ParamsList
	_,err :=rsuser.Filter("userId",userid).ValuesList(&rolelist,"RoleId")
	if err !=nil {
		return nil,err
	}
	return rolelist,nil
}

/**
 *根据用户获取，用户所有角色列表
 */
func (this *RoleAuth) GetRoleUserList(roleids [] string ) ([] orm.ParamsList, error){
	//根据userid查询角色Id
	o :=orm.NewOrm()
	rsroleauth :=o.QueryTable(new(RoleAuth))
	var roleauthlist [] orm.ParamsList
	_,err :=rsroleauth.Filter("RoleId__in",roleids).Distinct().OrderBy("AuthId").ValuesList(&roleauthlist,"AuthId")
	if err !=nil  {
		return nil,err
	}
	return roleauthlist,nil
}


func init()  {
	orm.RegisterModelWithPrefix("t_", new(Role), new(RoleUser), new(RoleAuth))
}