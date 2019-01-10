<% if f.object.fecha %>
  <% fr = f.object.fecha %>
<% else %>
  <% fr = Time.now.strftime('%Y-%m-%d') %>
<% end %>
<%  lp1 = Cor1440Gen::Proyectofinanciero.where(
  "fechainicio <= ? AND (? <= fechacierre OR fechacierre IS NULL)", 
  fr, fr)
ids1 = lp1.pluck(:id)
ids2 = f.object.proyectofinanciero.pluck(:id)
col = Cor1440Gen::Proyectofinanciero.where(id: ids1 | ids2)
%>
<% if defined? con_label %>
  <% l = con_label ? nil : false %>
<% else %>
  <% l = nil %>
<% end %>
<%= f.association :proyectofinanciero,
  collection: col,
  label_method: :nombre, 
  value_method: :id,
  label: l,
  input_html: { 
    class: 'chosen-select',
    "data-toggle" => 'tooltip',
    "title" => 'Los proyectos presentados son los vigentes en la fecha de la actividad (cambie la fecha para actualizar estas opciones)'
  }
%>
