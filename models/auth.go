package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type Auth struct {
	Id         int
	AuthCode   string
	AuthName   string
	Status     int
	ParentId   int
	AuthUrl    string
	AuthIcon   string
	AuthPath   string
	ParentPath string
	CreateUser string
	CreateTime time.Time
	UpdateTime time.Time
}

/**
 *根据权限Ids，获取权限列表
 */
func (this *Auth) GetAuthList(authids []string) ([]orm.ParamsList, error) {

	o := orm.NewOrm()
	rsuserauth := o.QueryTable(new(Auth))
	var authlist []orm.ParamsList
	_, err := rsuserauth.Filter("Id__in", authids).OrderBy("Id").ValuesList(&authlist, "Id", "AuthCode", "AuthName", "Status", "ParentId", "AuthUrl", "AuthPath", "ParentPath")
	if err != nil {
		return nil, err
	}
	return authlist, nil
}

/**
 *根据权限Ids，获取权限列表
 */
func (this *Auth) GetAuthMapList(authids []string, parentid int, parentPath string) ([]orm.Params, error) {

	o := orm.NewOrm()
	rsuserauth := o.QueryTable(new(Auth))
	var authlist []orm.Params
	rsuserauth = rsuserauth.Filter("Id__in", authids)
	if parentid > 0 {
		rsuserauth = rsuserauth.Filter("ParentId", parentid)
	}
	if parentPath != "" {
		rsuserauth = rsuserauth.Filter("ParentPath__istartswith", parentPath)
	}
	_, err := rsuserauth.OrderBy("Id").Values(&authlist, "Id", "AuthCode", "AuthName", "Status", "ParentId", "AuthUrl", "AuthPath", "ParentPath")
	if err != nil {
		return nil, err
	}
	return authlist, nil
}

func init() {
	orm.RegisterModelWithPrefix("t_", new(Auth))
}
