#lang racket

(require ts-curric-common)
(define-quests
  tutorial
  circle-game)

(require "./quizzes.rkt")
(require "./typing-game.rkt")
(require "./the-pictures-game.rkt")
(require "./the-pictures-game-2.rkt")
(require "./the-numbers-game.rkt")
(require "./the-numbers-game-2.rkt")
;(require "./the-racket-basics-game.rkt")
;(require "./the-shortcuts-game.rkt")

(provide
 (all-from-out "./quizzes.rkt")
 (all-from-out "./typing-game.rkt")
 (all-from-out "./the-pictures-game.rkt")
 (all-from-out "./the-pictures-game-2.rkt")
 (all-from-out "./the-numbers-game.rkt")
 (all-from-out "./the-numbers-game-2.rkt")
 ;(all-from-out "./the-racket-basics-game.rkt")
 #;(all-from-out "./the-shortcuts-game.rkt"))
