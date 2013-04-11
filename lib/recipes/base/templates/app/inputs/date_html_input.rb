# -*- encoding : utf-8 -*-
class DateHtmlInput < SimpleForm::Inputs::Base
  def input
    @builder.text_field attribute_name, input_html_options.merge!(:type => :date, :class => 'input-small')
  end
end
