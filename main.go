package main

import (
	_ "beegodemo/routers"
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
)

func init() {
	//配置数据库
	dbDriverName := beego.AppConfig.String("mysqldrivername")
	MysqlUser := beego.AppConfig.String("mysqluser")
	MysqlPass := beego.AppConfig.String("mysqlpass")
	MysqlDB := beego.AppConfig.String("mysqldb")
	MysqlHost := beego.AppConfig.String("mysqlhost")
	MysqlPort := beego.AppConfig.String("mysqlport")

	orm.RegisterDriver(dbDriverName, orm.DRMySQL)
	orm.RegisterDataBase("default", dbDriverName, fmt.Sprint(MysqlUser, ":", MysqlPass, "@tcp(", MysqlHost, ":", MysqlPort, ")/", MysqlDB, "?charset=utf8"))

}

func main() {

	o := orm.NewOrm()
	o.Using("default")

	beego.Run()
}
