FactoryBot.define do
  factory :campaign do
    user
    industry
    email_limit { 1 }
    subject { "Campaña Autimatica" }
    body { "<p>Contenido de prueba</p>" }
    status { "pending" }
  end
end
