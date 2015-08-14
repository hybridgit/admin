module PermissionsHelper

  def controllerName(controller)
    controller.split(/(?=[A-Z])/)[0..-2].join(" ")
  end

end
