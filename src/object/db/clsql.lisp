(in-package :cl-ws-object)

(shadowing-import '(clsql::connect clsql::database))
(shadowing-import '(clsql::disconnect clsql::database))
(shadowing-import '(clsql::sql-fatal-error clsql::database))

(defmethod setup-db ((service <service>) &key name scheme type)
  (lt1 db (connect-db scheme type)
    (setf (gethash name (dbs-of service)) db)))

(defun connect-db (scheme type)
  (connect (list (namestring scheme))
	   :if-exists :old :database-type type))

(defmethod cleanup-db ((service <service>) &key name)
  (handler-case (disconnect :database (get-db service :name name) :error nil)
    ; db closed case. 					
    (sql-fatal-error nil))
  (remhash name (dbs-of service)))
