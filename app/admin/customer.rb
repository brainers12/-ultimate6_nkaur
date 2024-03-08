ActiveAdmin.register Customer do
  # Permit the parameters for Customer, including the image attachment
  permit_params :full_name, :phone_number, :email_address, :notes, :image

  # Create form for New/Create and Edit/Update
  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs 'Customer Details' do
      f.input :full_name
      f.input :phone_number
      f.input :email_address
      f.input :notes
    end

    f.inputs 'Customer Image', multipart: true do
      f.input :image, as: :file
      if f.object.image.attached?
        div do
          image_tag(f.object.image.variant(resize_to_limit: [100, 100]))
        end
      end
    end

    f.actions # adds the 'Submit' and 'Cancel' buttons
  end

  # Display individual customer details
  show do
    attributes_table do
      row :full_name
      row :phone_number
      row :email_address
      row :notes
      row :image do |customer|
        if customer.image.attached?
          image_tag customer.image.variant(resize_to_limit: [100, 100])
        else
          text_node "No image uploaded"
        end
      end
    end
    active_admin_comments
  end

  # Display all customers in the index
  index do
    selectable_column
    id_column
    column :full_name
    column :phone_number
    column :email_address
    column :notes
    column 'Image' do |customer|
      if customer.image.attached?
        image_tag customer.image.variant(resize_to_limit: [100, 100])
      else
        text_node "No image uploaded"
      end
    end
    actions
  end

  # Set up filters for searching (only for fields, no filters for image attachment)
  filter :full_name_cont, label: 'Full Name'
  filter :phone_number_cont, label: 'Phone Number'
  filter :email_address_cont, label: 'Email'
  filter :notes_cont, label: 'Notes'

  # You can define a page action here if needed

  # Controller customization if required
  # ...
end

