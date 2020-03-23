package models

import (
	"errors"
	"github.com/astaxie/beego/orm"
	"time"
)

type User struct {
	Id         int
	UserName   string    `orm:"column(user_name)"`
	Name       string    `orm:"column(name)"`
	PassWord   string    `orm:"column(pass_word)"`
	Mobile     string    `orm:"column(mobile)"`
	Email      string    `orm:"column(email)"`
	Status     int       `orm:"column(status)"`
	CreateUser string    `orm:"column(create_user)"`
	CreateTime time.Time `orm:"column(create_time)"`
	UpdateTime time.Time `orm:"column(update_time)"`
}

func (this *User) GetUserInfo() (User, error) {
	o := orm.NewOrm()
	var userm User
	var errr error
	if this.UserName != "" {
		userm = User{UserName: this.UserName}
		errr = o.Read(&userm, "UserName")
	} else {
		userm = User{Id: this.Id}
		errr = o.Read(&userm)
	}
	if errr == orm.ErrNoRows {
		return userm, errors.New("No User Data")
	} else if errr == orm.ErrMissPK {
		return userm, errors.New("No User Data")
	} else {
		return userm, nil
	}

	return userm, errors.New("No User Data")
}

/**
 *添加用户数据
 */

func (this *User) Add() (int64, error) {
	o := orm.NewOrm()
	oUser := new(User)
	oUser.UserName = this.UserName
	oUser.Mobile = this.Mobile
	oUser.Email = this.Email
	oUser.Status = this.Status
	oUser.Name = this.Name
	oUser.PassWord = this.PassWord
	oUser.CreateUser = "admin"
	oUser.CreateTime = time.Now()
	result, err := o.Insert(oUser)
	if err == nil {
		return result, nil
	}
	return 0, err
}

/**
 * 更新用户数据
 */
func (this *User) Update(user User) (int64, error) {
	o := orm.NewOrm()
	oUser := User{Id: user.Id}
	err := o.Read(&oUser)
	if err == nil {
		oUser.UserName = user.UserName
		oUser.Mobile = user.Mobile
		oUser.Email = user.Email
		oUser.Status = user.Status
		oUser.Name = user.Name
		oUser.UpdateTime = time.Now()
		num, err := o.Update(&oUser)
		if err == nil {
			return num, nil
		}
		return 0, err
	} else {
		return 0, err
	}
}

func (this *User) Delete(id int) (int64, error) {
	o := orm.NewOrm()
	oUser := User{Id: id}
	num, err := o.Delete(&oUser)
	if err == nil {
		return num, nil
	}
	return 0, err

}

/**
 * 获取所有用户列表
 */
func (this *User) GetUserList(user User) ([]orm.Params, error) {
	//根据userid查询角色Id
	o := orm.NewOrm()
	rsuser := o.QueryTable(new(User))
	if user.UserName != "" {
		rsuser.Filter("UserName__icontains", user.UserName)
	}
	if user.Name != "" {
		rsuser.Filter("Name__icontains", user.Name)
	}
	if user.Mobile != "" {
		rsuser.Filter("Mobile__icontains", user.Mobile)
	}
	if user.Email != "" {
		rsuser.Filter("Email__icontains", user.Email)
	}
	if user.Status >= -1 {
		rsuser.Filter("Status", user.Status)
	}
	var userlist []orm.Params
	_, err := rsuser.Values(&userlist)
	if err != nil {
		return nil, err
	}
	return userlist, nil
}

func init() {
	orm.RegisterModelWithPrefix("t_", new(User))
}
