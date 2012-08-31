#|

 Fundamental Vector Operations

 Copyright (c) 2009-2012, Odonata Research LLC
 All rights reserved.

 Redistribution and  use  in  source  and  binary  forms, with or without
 modification, are permitted  provided  that the following conditions are
 met:

   o  Redistributions of  source  code  must  retain  the above copyright
      notice, this list of conditions and the following disclaimer.
   o  Redistributions in binary  form  must reproduce the above copyright
      notice, this list of  conditions  and  the  following disclaimer in
      the  documentation  and/or   other   materials  provided  with  the
      distribution.
   o  The names of the contributors may not be used to endorse or promote
      products derived from this software without  specific prior written
      permission.

 THIS SOFTWARE IS  PROVIDED  BY  THE  COPYRIGHT  HOLDERS AND CONTRIBUTORS
 "AS IS"  AND  ANY  EXPRESS  OR  IMPLIED  WARRANTIES, INCLUDING,  BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES  OF MERCHANTABILITY AND FITNESS FOR A
 PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
 OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR  CONSEQUENTIAL  DAMAGES  (INCLUDING,  BUT  NOT LIMITED TO,
 PROCUREMENT OF  SUBSTITUTE  GOODS  OR  SERVICES;  LOSS  OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION)  HOWEVER  CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER  IN  CONTRACT,  STRICT  LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR  OTHERWISE)  ARISING  IN  ANY  WAY  OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

|#

(in-package :linear-algebra)

(defmethod sumsq ((data vector) &key (scale 0) (sumsq 1))
  "Return the scaling parameter and the sum of the squares of the
vector."
  (let ((size (length data))
        (abs-val nil))
    (dotimes (index size (values scale sumsq))
      (when (plusp (setf abs-val (abs (svref data index))))
        (if (< scale abs-val)
            (setf
             sumsq (1+ (* sumsq (expt (/ scale abs-val) 2)))
             scale abs-val)
            (incf sumsq (expt (/ (svref data index) scale) 2)))))))

(defmethod sump ((data vector) (p real) &key (scale 0) (sump 1))
  "Return the scaling parameter and the sum of the powers of p of the
vector."
  (let ((size (length data))
        (abs-val nil))
    (dotimes (index size (values scale sump))
      (when (plusp (setf abs-val (abs (svref data index))))
        (if (< scale abs-val)
            (setf
             sump (1+ (* sump (expt (/ scale abs-val) p)))
             scale abs-val)
            (incf sump (expt (/ (svref data index) scale) p)))))))
