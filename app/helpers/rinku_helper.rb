require 'rails_rinku'

module RinkuHelper
    def run_rinku(text) 
        auto_link(text, :html => { :target => '_blank' })
    end
end