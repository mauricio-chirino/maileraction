module ApplicationHelper
  def js_translations
    translations = {
      "block.eliminado" => I18n.t("helpers.block.eliminado"),
      "block.agregado" => I18n.t("helpers.block.agregado"),
      "error.cargando" => I18n.t("helpers.error.cargando"),
      "guardar" => I18n.t("helpers.guardar"),
      "cancelar" => I18n.t("helpers.cancelar")
    }

    content_tag :div, id: "js-translations", style: "display:none;", **(
      translations.transform_keys { |k| "data-#{k.split('.').map.with_index { |p, i| i == 0 ? p : p.capitalize }.join('') }" }
    ) do
      ""
    end
  end
end
