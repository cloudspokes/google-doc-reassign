package com.thirdchimpanzee.exportmydoc.entity;


public class DocConversion {
   String oldDocId;
   String newDocId;
public DocConversion(String oldDocId, String newDocId) {
	super();
	this.oldDocId = oldDocId;
	this.newDocId = newDocId;
}
/**
 * @return the oldDocId
 */
public String getOldDocId() {
	return oldDocId;
}
/**
 * @param oldDocId the oldDocId to set
 */
public void setOldDocId(String oldDocId) {
	this.oldDocId = oldDocId;
}
/**
 * @return the newDocId
 */
public String getNewDocId() {
	return newDocId;
}
/**
 * @param newDocId the newDocId to set
 */
public void setNewDocId(String newDocId) {
	this.newDocId = newDocId;
}


}
