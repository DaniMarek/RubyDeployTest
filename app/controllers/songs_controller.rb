class SongsController < ApplicationController
	skip_before_action :require_login, except:[:destroy]

	def index
		@songs = Song.all

		# song.user
	end

	def show
		@song = Song.find(params[:id])
		render "/songs/show"
	end

    def add
        add_song = Song.find(params[:id])
        p "My song id is: #{add_song.id}"
		@count = Join.where(user_id: current_user, song_id: add_song.id)
		p 'join', @count
		p 'length', @count.length
		p 'comp', @count.length > 0
		p 'empty', @count.empty?
		if @count.length > 0
			plus = @count[0]
			plus.count += 1
			plus.save
		else
        	# current_user.songs << song

			count_new = Join.create(user_id: current_user.id, song_id: add_song.id, count: 1)
		end
        redirect_to :back
    end
    
	def create
		@song = Song.create(title: params[:title], artist: params[:artist])
		# this creates a new song
		if @song.valid?
			# if song is valid, save it and redirect to /songs
			count_new = Join.create(user_id: current_user.id, song_id: @song.id, count: 1)
			redirect_to :back
		else
			flash[:alert] = @song.errors.full_messages
			redirect_to :back
		end
	end

	private
	helper_method def song
		@song ||=Song.find_by_id(params[:id])
	end

end
