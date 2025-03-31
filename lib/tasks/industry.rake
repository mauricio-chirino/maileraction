# frozen_string_literal: true

# This file is part of the Rails application.
# It is subject to the license terms in the LICENSE file found in the top-level directory of this distribution and at
# https://opensource.org/licenses/MIT.
# This file is distributed WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the LICENSE file for more details.
#
namespace :industry do
  desc "Recalcula los contadores de emails por industria"
  task reset_email_counts: :environment do
    Industry.find_each do |industry|
      Industry.reset_counters(industry.id, :public_email_records)
    end
    puts "✅ Contadores de emails recalculados"
  end
end



# Para que funcione ejecutar
# bin/rails industry:reset_email_counts
