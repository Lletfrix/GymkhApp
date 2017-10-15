get_nearby_locations = $.getJSON('https://api.foursquare.com/v2/venues/explore', {client_id: 'E1FYBEMIEJM40IDG0Z040F0RGUP51QSBX3OL3XXFVBDOPNYO', client_secret: 'U0G32SBWNK0VADAWZGSLDVIDZER1VOXELIIWIQSHKC0WD10W', ll: '41.3889541,2.1131256', v: '20170801', radius: 15000, limit: 50, section: 'sights'})

# populate place select with nearby locations
$(document).on 'turbolinks:load', ->
  $.when(get_nearby_locations).then (data) ->
    fsq_opts = []
    data.response.groups.forEach (g) ->
      g.items.forEach (i) ->
        fsq_opts.push({id: i.venue.id + ';' + i.venue.name, text: i.venue.name})

    $('.fsq-select').select2 {theme: 'bootstrap', data: fsq_opts}

    $('#add_challenge_btn').click (e) ->
      e.preventDefault()
      n = (new Date()).getTime()
      challenge_form = '<div class="form-group string optional game_challenges_title"><label class="control-label string optional" for="game_challenges_attributes_' + n + '_title">Title</label><input class="form-control string optional" type="text" name="game[challenges_attributes][' + n + '][title]" id="game_challenges_attributes_' + n + '_title"></div>'
      challenge_form += '<div class="form-group text optional game_challenges_description"><label class="control-label text optional" for="game_challenges_attributes_' + n + '_description">Description</label><textarea class="form-control text optional" name="game[challenges_attributes][' + n + '][description]" id="game_challenges_attributes_' + n + '_description"></textarea></div>'
      challenge_form += '<div class="form-group"><label class="control-label string" for="game[challenges_attributes][' + n + '][foursquare_id]">Location:</label><select name="game[challenges_attributes][' + n + '][foursquare_id]" class="fsq-select form-control"></select></div><hr>'
      $('.challenges-forms').append(challenge_form)

      $('.fsq-select').select2 {theme: 'bootstrap', data: fsq_opts}
