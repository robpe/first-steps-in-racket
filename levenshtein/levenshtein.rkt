; Levenshtein distance calculation
#lang racket

(require (planet dherman/memoize:3:1))

(provide distance)
(provide lmax)

; alias: maximum/minimum element for list
(define (lmax l) (apply max l))
(define (lmin l) (apply min l))
; alias string length
(define (slen s) (string-length s))

; define-memoized from - http://blog.jverkamp.com/2012/10/20/memoization-in-racket/
(define-syntax define-memoized
  (syntax-rules ()
    [(_ (f args ...) bodies ...)
     (define f
       (let ([results (make-hash)])
         (lambda (args ...)
           ((lambda vals
              (when (not (hash-has-key? results vals))
                (hash-set! results vals (begin bodies ...)))
              (hash-ref results vals))
            args ...))))]))


(define-memoized (distance s1 s2)
  (cond
    [ (equal? (slen s1) 0) (slen s2) ]
    [ (equal? (slen s2) 0) (slen s1) ]
    [else
      (let ([cost (if (char=? (string-ref s1 0) (string-ref s2 0)) 0 1)]) 
        (lmin (list 
          (+ (distance (substring s1 1) s2) 1)
          (+ (distance (substring s2 1) s1) 1)
          (+ (distance (substring s1 1) (substring s2 1)) cost))))]))
