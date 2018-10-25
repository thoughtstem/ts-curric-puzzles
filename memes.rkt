#lang racket

(provide xena)

(require ts-racket
         2htdp/image
         racket/runtime-path
         "./image-util.rkt")

(define-runtime-path images "images")

(define-syntax-rule (define-meme id)
  (begin
    (provide id)
    (define bg
      (scale-to-fit 
       (bitmap/file (build-path images (~a 'id ".png")))
       350))
    (define (id (top "")
                (bottom ""))
      (meme bg top bottom))))


(define-meme xena)
(define-meme picard)
(define-meme fry)

(define (meme bg top bottom)
  (overlay/align "middle" "bottom"
                 (random-rotate
                  (fluff (text bottom 24 'white) 'black))
                 (overlay/align "middle" "top"
                                (random-rotate
                                 (fluff (text top 30 'white) 'black))
                                bg)))


(module+ test
  (xena "Hi")
  (fry "HI")
  (picard "HI"))