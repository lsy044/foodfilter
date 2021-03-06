class RecipesController < ApplicationController
  
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  impressionist actions: [:show]
  # GET /recipes
  # GET /recipes.json
  def index

    @recipe_key = params[:recipe_word]
    @allergy_tags=["난류", "우유", "복숭아", "토마토", "메밀", "밀", "대두(콩)", "닭고기", "쇠고기", "돼지고기", "새우", "고등어", "홍합", "전복", "굴", "조개류", "게", "오징어", "호두", "땅콩", "아황산류"]

    recipes = if params[:recipe_word]
      if params[:recipe_word] == ""
        @recipes = Kaminari.paginate_array(Recipe.all.order("created_at DESC")).page(params[:page]).per(9)
        return
      end
      key_del = @recipe_key.delete"#"
      @recipe_keys = key_del.split(' ')
      count = @recipe_keys.length()
      for idx in 0...count
        key = "%#{@recipe_keys[idx]}%"
        
        recipe = Recipe.where("title  LIKE (?) || explanation LIKE (?) || allergyfor LIKE (?) ", key, key, key).order("created_at DESC")
        if idx == 0
          @recipes = recipe
        else
          @recipes = @recipes & recipe
        end
      end
      @recipes = Kaminari.paginate_array(@recipes.uniq).page(params[:page]).per(9)
    else
      @recipes = Kaminari.paginate_array(Recipe.all.order("created_at DESC")).page(params[:page]).per(9)
    end
    
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @ingredients = @recipe.ingredients
    @ingredients = @ingredients.split("\n")
    puts @ingredients
  end

  # GET /recipes/new
  def new
    if user_signed_in? && current_user.name == nil
      flash[:warning] ='닉네임을 설정해주세요'
      redirect_to edit_user_registration_path
    end
    @recipe = Recipe.new
    @allergy_tags=["난류", "우유", "복숭아", "토마토", "메밀", "밀", "대두(콩)", "닭고기", "쇠고기", "돼지고기", "새우", "고등어", "홍합", "전복", "굴", "조개류", "게", "오징어", "호두", "땅콩", "아황산류"]
  end

  # GET /recipes/1/edit
  def edit
    @allergy_tags=["난류", "우유", "복숭아", "토마토", "메밀", "밀", "대두(콩)", "닭고기", "쇠고기", "돼지고기", "새우", "고등어", "홍합", "전복", "굴", "조개류", "게", "오징어", "호두", "땅콩", "아황산류"]
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @recipe.name = current_user.name
    @recipe.category = "레시피"

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:allergyfor, :recipeimage0, :title, :explanation, :ingredients, :tag, :content1, :content2, :content3, :content4, :content5, :content6, :content7, :content8, :content9, :content10,
         :recipeimage1, :recipeimage2, :recipeimage3, :recipeimage4, :recipeimage5, :recipeimage6, :recipeimage7, :recipeimage8, :recipeimage9, :recipeimage10)
    end
end
