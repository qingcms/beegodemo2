package controllers

type AuthController struct {
	BaseController
}

func (this *AuthController) Get() {

	this.TplName = "user/list.tpl"

}
