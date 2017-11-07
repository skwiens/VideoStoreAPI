require "test_helper"

describe MoviesController do
  let(:psycho) {movies(:psycho)}
  describe "INDEX" do
    it "successfully returns json as an Array" do
      get movies_path
      must_respond_with :ok

      response.header['Content-Type'].must_include 'json'

      body = JSON.parse(response.body)
      body.must_be_instance_of Array
    end

    it 'returns ALL of the movies' do
      get movies_path
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns customers with exactly the fields required" do
      keys = %w(id title release_date)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys.sort
      end
    end

    it "returns an empty array if there are no Movies" do
      Movie.destroy_all
      get movies_path
      must_respond_with :ok
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end

  describe "SHOW" do
    it "Can get a single Movie" do
      get movie_path(psycho.id)
      must_respond_with :success
    end

    it "Returns json that includes title, overview, release_date and inventory(total)" do
      keys = %w(title overview release_date inventory)
      get movie_path(psycho.id)

      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys.sort
    end
    
    it "Returns an error for an invalid id" do
      psycho.destroy
      get movie_path(psycho.id)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body["ok"].must_equal false
    end
  end # SHOW

end
