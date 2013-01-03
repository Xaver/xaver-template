# -*- encoding : utf-8 -*-
module MiniForm
  def mini_form_for(object, *args, &block)
    options = args.extract_options!
    html_options = { :html => {} }
    options = options.present? ? options.reverse_merge!(:html => {}) : html_options
    options[:html].merge! :class => [options[:html].fetch(:class, nil), 'form-inline'].compact.join(" ")
    options.merge! :wrapper => :mini, :defaults => { :required => false }
    simple_form_for(object, *(args << options.merge(:builder => MiniFormBuilder)), &block)
  end

  class MiniFormBuilder < SimpleForm::FormBuilder
    def input(attribute_name, options = {}, &block)
      options.reverse_merge! :label => false
      super
    end
  end

  # Wrapper para Mini Formularios 
  # TODO: encontrar la manera de cambiar la clase de todos los input por 'input-medium'
  SimpleForm.setup do |config|
    config.wrappers :mini, :tag => 'span' , :class => 'controls', :error_class => 'error' do |b|
      b.use :html5
      b.use :placeholder
      b.use :input
      b.use :label
      b.use :error, :wrap_with => { :tag => 'span', :class => 'help-inline' }
    end
  end
end
