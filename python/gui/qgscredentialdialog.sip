/************************************************************************
 * This file has been generated automatically from                      *
 *                                                                      *
 * src/gui/qgscredentialdialog.h                                        *
 *                                                                      *
 * Do not edit manually ! Edit header and run scripts/sipify.pl again   *
 ************************************************************************/





class QgsCredentialDialog : QDialog, QgsCredentials
{
%Docstring
 A generic dialog for requesting credentials
%End

%TypeHeaderCode
#include "qgscredentialdialog.h"
%End
  public:
    QgsCredentialDialog( QWidget *parent /TransferThis/ = 0, Qt::WindowFlags fl = QgisGui::ModalDialogFlags );
%Docstring
QgsCredentialDialog constructor
%End


  protected:
    virtual bool request( const QString &realm, QString &username /In,Out/, QString &password /In,Out/, const QString &message = QString::null );

    virtual bool requestMasterPassword( QString &password /In,Out/, bool stored = false );

};

/************************************************************************
 * This file has been generated automatically from                      *
 *                                                                      *
 * src/gui/qgscredentialdialog.h                                        *
 *                                                                      *
 * Do not edit manually ! Edit header and run scripts/sipify.pl again   *
 ************************************************************************/
