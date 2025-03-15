# script/check_serializers.rb

serializer_dir = Rails.root.join("app", "serializers")

Dir.glob("#{serializer_dir}/**/*_serializer.rb").each do |file_path|
  # Obtener el nombre relativo desde app/serializers
  relative_path = Pathname.new(file_path).relative_path_from(serializer_dir)
  
  # Convertir el path del archivo a un nombre de clase (CamelCase)
  class_name = relative_path.to_s.sub(".rb", "").split("/").map do |part|
    part.split("_").map(&:capitalize).join
  end.join("::")

  begin
    # Forzar carga de la constante
    klass = class_name.constantize
    puts "✅ #{class_name} cargado correctamente"
  rescue NameError => e
    puts "❌ Error al cargar #{class_name}: #{e.message}"
  end
end
