module Library

    #fill in the search box in the library and hit enter and select the item
    def library_search(message)
        find("#contentManager > div.ff-header.hideFilter > div.ff-search > input[type='text']").set(message + "\n")
        find("#contentManager > div.ff-body > div.ff-object-listing > div > div.ff-object.shout > div.ff-object-img").click
    end

    #share button in library
    def library_share
        find("#contentManager > div.ff-body > div.ff-object-preview > div > div > div.ff-preview-actions > div.button.alternate.ff-preview-share").click
    end

    #share button in the modal
    def library_share_modal
        find("#contentManager-shoutlet-share-objects-modal > div.modal-content > div.fr.ff-modal-confirm.button").click
    end

    #distribute in the library
    def library_dist(message)
        library_search(message)
        find("#contentManager > div.ff-body > div.ff-object-preview > div > div > div.ff-preview-actions > div").click
    end

    #delete in the library, item is selected > delete is clicked and delete in modal is clicked
    def library_delete(message)
        library_search(message)
        find("#contentManager > div.ff-body > div.ff-object-preview > div > div > div.ff-preview-options > div.ff-preview-action.ff-preview-delete").click
        find("#contentManager-shoutlet-delete-objects-modal > div.modal-content > div.fr.ff-modal-confirm.button").click
    end

end