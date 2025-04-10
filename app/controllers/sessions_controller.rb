class SessionsController < ApplicationController
  before_action :allow_unauthenticated_access, only: %i[new create]

  # Método para mostrar la página de inicio de sesión (si fuera necesario, en la vista)
  def new
  end

  # Método para crear una nueva sesión (inicio de sesión)
  def create
    # Aquí buscamos al usuario por el campo `email_address` en lugar de `email`
    user = User.find_by(email_address: params[:email_address])

    if user&.authenticate(params[:password])  # Verifica que la contraseña sea correcta
      start_new_session_for user  # Aquí puedes implementar el inicio de sesión, como por ejemplo usando cookies o el sistema que prefieras
      render json: { message: "Sesión iniciada", user: user.email_address }, status: :ok
    else
      render json: { error: "Email o contraseña inválidos" }, status: :unauthorized
    end
  end

  # Método para destruir la sesión (cerrar sesión)
  def destroy
    terminate_session # Implementa este método para eliminar la sesión, por ejemplo, eliminando cookies
    render json: { message: "Sesión cerrada correctamente" }, status: :ok
  end

  private

  # Permitimos acceso sin autenticación solo para las acciones `new` y `create`
  def allow_unauthenticated_access
    allow_unauthenticated_access only: %i[new create]
  end

  # Método para iniciar sesión del usuario (puedes implementar cómo gestionas la sesión)
  def start_new_session_for(user)
    session[:user_id] = user.id  # Usando Rails session para almacenar el ID del usuario
  end

  # Método para terminar la sesión del usuario
  def terminate_session
    reset_session  # Esta es una forma de eliminar la sesión en Rails
  end
end
