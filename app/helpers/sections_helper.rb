module SectionsHelper

    def check_section 
        if valid_section_param? 
            Section.find(params[:section].to_i)
        end
    end

    def valid_section_param? 
        !params[:section].to_i.zero?  
    end
end