module SuggestionsHelper

  def display_music_name(name)
    if name.length > 33
      display_name = name[0..30] + "..."
    else
      display_name = name
    end
    display_name
  end

  def display_food_name(name)
    if name.length > 25
      display_name = name[0..22] + "..."
    else
      display_name = name
    end
    display_name
  end
end
