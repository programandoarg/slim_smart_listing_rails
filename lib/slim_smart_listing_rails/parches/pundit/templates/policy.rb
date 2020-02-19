# generado con https://github.com/programandoarg/slim_smart_listing_rails

<% module_namespacing do -%>
class <%= class_name %>Policy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
<% end -%>
