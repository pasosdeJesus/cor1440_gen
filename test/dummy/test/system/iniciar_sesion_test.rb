require "application_system_test_case"

class IniciarSesionTest < ApplicationSystemTestCase

  test "iniciar sesión" do
    skip
    Msip::CapybaraHelper.iniciar_sesion(self, root_path, 'cor1440', 'cor1440')
  end

end
