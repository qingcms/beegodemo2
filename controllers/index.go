package controllers

type IndexController struct {
	BaseController
}

func (this *IndexController) Get() {
	this.TplName = "index.tpl"

}
