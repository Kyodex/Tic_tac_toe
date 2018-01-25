class Player#Joueur
  attr_accessor :name
end

class Board_Case#Case de la grille

  attr_accessor :value

 def initialize
  @value = " "
 end

  def x #Remplie la case d'un "X"
    @value = "X"
  end

  def o #Remplie la case d'un "O"
    @value = "O"
  end
end


class Board#Creation de la grille

attr_accessor :table

def initialize
  @table={"a1"=>Board_Case.new,"a2"=>Board_Case.new,"a3"=>Board_Case.new, #Crée les 9 cases de la grille
           "b1"=>Board_Case.new,"b2"=>Board_Case.new,"b3"=>Board_Case.new,
           "c1"=>Board_Case.new,"c2"=>Board_Case.new,"c3"=>Board_Case.new}
end

 def print_board#Affichage de la grille
  puts
  puts "  | 1 | 2 | 3 |"
  puts "---------------"
  puts "a | #{@table["a1"].value} | #{@table["a2"].value} | #{@table["a3"].value} |"
  puts "---------------"
  puts "b | #{@table["b1"].value} | #{@table["b2"].value} | #{@table["b3"].value} |"
  puts "---------------"
  puts "c | #{@table["c1"].value} | #{@table["c2"].value} | #{@table["c3"].value} |"
  puts
 end
end

class Game
  $w = false#Variable permmetant de savoir si l'un des joueur a gagné
  $co = 0 #variables pour le match nul(compteur de coup joué)
  def set_player#Nommer les joueurs
    player_1 = Player.new
    player_2 = Player.new

    puts "Name of player 1 ?"
    player_1.name = gets.chomp
    $n1 = player_1.name#Variable qui nous permettra d'afficher le nom du joueur
    puts "Name of player 2 ?"
    player_2.name = gets.chomp
    $n2 = player_2.name
  end

  def set_board#Crée la grille
    @board = Board.new
  end

  def player1_turn #Tour joueur 1
    $i = 0 #variable qui nous permettra de distinguer le joueur 1 du 2 lors du win_check
    puts "#{$n1}...Choose your case"
    ca = gets.chomp#choix de la case

    while ca != "a1" && ca != "a2" && ca != "a3" &&
          ca != "b1" && ca != "b2" && ca != "b3" &&
          ca != "c1" && ca != "c2" && ca != "c3" do #Tant que la case n'est pas vide : choisissez une autre case
      puts "Is not a case choose another one pls"
      ca = gets.chomp
    end
    puts @board.table[ca].value#Affiche la case choisie

    if @board.table[ca].value == " " #Si case vide la remplire avec X
      @board.table[ca].x #Remplie avec X
      @board.print_board #Affiche la grille
    else
      puts "not empty choose another" #Case Remplie en choisir une autre
      ca = gets.chomp
      @board.table[ca].x
      @board.print_board
    end
  end


def player2_turn#Tour joueur 2 (idem que joueur 1)
  $i = 1
  puts "#{$n2}...Choose your case"
  ca = gets.chomp

  while ca != "a1" && ca != "a2" && ca != "a3" &&
        ca != "b1" && ca != "b2" && ca != "b3" &&
        ca != "c1" && ca != "c2" && ca != "c3" do
    puts "Is not a case choose another one pls"
    ca = gets.chomp
  end
  puts @board.table[ca].value

  if @board.table[ca].value == " "
    @board.table[ca].o
    @board.print_board
  else
    puts "not empty choose another"
    ca = gets.chomp
    @board.table[ca].o
    @board.print_board
  end
end

def win_check #Verification de toutes les combinaisons gagnante
  if (@board.table["a1"].value==@board.table["a2"].value) && #Première ligne
     (@board.table["a2"].value==@board.table["a3"].value) &&
     (@board.table["a1"].value!=" ") ||
     (@board.table["b1"].value==@board.table["b2"].value) &&# 2nd
     (@board.table["b2"].value==@board.table["b3"].value) &&
     (@board.table["b1"].value!=" ") ||
     (@board.table["c1"].value==@board.table["c2"].value) && #3rd ligne
     (@board.table["c2"].value==@board.table["c3"].value) &&
     (@board.table["c1"].value!=" ") ||
     (@board.table["a1"].value==@board.table["b1"].value) &&#1er Colonne
     (@board.table["b1"].value==@board.table["c1"].value) &&
     (@board.table["a1"].value!=" ") ||
     (@board.table["a2"].value==@board.table["b2"].value) &&#2nd
     (@board.table["b2"].value==@board.table["c2"].value) &&
     (@board.table["a2"].value!=" ") ||
     (@board.table["a3"].value==@board.table["b3"].value) &&#3nd
     (@board.table["b3"].value==@board.table["c3"].value) &&
     (@board.table["a3"].value!=" ") ||
     (@board.table["a1"].value==@board.table["b2"].value) &&# 1er diagonale
     (@board.table["b2"].value==@board.table["c3"].value) &&
     (@board.table["b2"].value!=" ") ||
     (@board.table["a3"].value==@board.table["b2"].value) &&#Dernière diagonale
     (@board.table["b2"].value==@board.table["c1"].value) &&
     (@board.table["b2"].value!=" ")
       $w = true #Variable qui nous permettre de mettre fin a la partie
     else
       $w = false
       end
       if $i % 2 == 0 && $w == true #Verification du joueur
         puts "#{$n1}....Win!"
       elsif $i % 2 == 1 && $w == true
         puts "#{$n2}...Win !!"
      end
    end


  def go#Lance la partie
    set_player
    set_board
    while $w == false do #Tant que $w est faux la partie continue
      @board.print_board
      player1_turn
      $co += 1
      win_check#Verifie si le joueur a gagné
      if $co==9 && $w==false
        puts"Draw!!!"
      end
      break if ($co==9)#Quitte si c'est un match nul
      break if ($w == true)#Arret du game si le joueur 1 gagne (si $w = vrai)
      player2_turn
      $co += 1
      win_check
    end
    puts "END OF GAME!!!!!"
  end
end

game = Game.new
game.go
