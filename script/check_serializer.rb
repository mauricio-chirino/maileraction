# script/check_serializers.rb
require 'active_model_serializers'

puts "🔎 Verificando serializers definidos en app/serializers...\n\n"

Dir.glob(Rails.root.join("app/serializers/*_serializer.rb")).each do |file|
  require_dependency file
end

serializers = ActiveModel::Serializer.descendants.uniq

serializers.each do |serializer_class|
  begin
    puts "🔍 #{serializer_class.name}"

    attributes = serializer_class._attributes_data.keys
    puts "  🧩 Atributos: #{attributes.any? ? attributes.join(', ') : '❌ Ninguno'}"

    reflections = serializer_class._reflections

    if reflections.empty?
      puts "  🔗 Relaciones:\n    ❌ Ninguna"
    else
      puts "  🔗 Relaciones:"
      reflections.each do |name, reflection|
        reflection_type =
          case reflection
          when ActiveModel::Serializer::BelongsToReflection then :belongs_to
          when ActiveModel::Serializer::HasManyReflection then :has_many
          else :unknown
          end

        serializer_defined = reflection.options[:serializer]

        if serializer_defined
          puts "    ✅ #{reflection_type} :#{name} — serializer: #{serializer_defined}"
        else
          puts "    ⚠️  #{reflection_type} :#{name} — serializer no definido"
        end
      end
    end

    puts "\n"

  rescue => e
    puts "❌ Error al cargar #{serializer_class.name}: #{e.message}"
    puts "\n"
  end
end
