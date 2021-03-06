package edu.pitt.domain;

import edu.pitt.utilities.DbUtilities;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Hashtable;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Liu
 */
public class Workspace {

    private int userID;
    private String groupID;
    private Hashtable<String, Result> resultList = new Hashtable<String, Result>();

    public Workspace(int userID, String groupID) {
        this.userID = userID;
        this.groupID = groupID;
        loadGroupResults();
    }

    /**
     * retrieve all results into the resutlList, of which group the
     * authenticatedUser is in
     *
     * @param groupID
     */
    public void loadGroupResults() {
        String sql = "SELECT * FROM  WEat.Result ";
        sql += " WHERE `groupID` = '" + this.groupID + "' ;";
        System.out.println("[loadGroupResults]sql = " + sql);
        DbUtilities db = new DbUtilities();
        try {
            ResultSet rs = db.getResultSet(sql);
            while (rs.next()) {
                String resultID = rs.getString("resultID");
                // Create Result  object here for each resultID
                Result result = new Result(resultID, groupID);
                // Add each account to customerList
                resultList.put(resultID, result);
                System.out.println("[loadGroupResults]resultList = " + resultList);
            }
        } catch (SQLException e) {
            System.out.println("Cannot load group results.");
            e.printStackTrace();
        } finally {
            db.closeDbConnection();
        }
    }//end of loadGroupResults

    public Hashtable<String, Result> getReultList() {
        return this.resultList;
    }

    public String[] getResultIDList() {
        String[] resultIDList = new String[this.resultList.size()];
        Enumeration<String> resultsID = resultList.keys();
        int i = 0;
        while (resultsID.hasMoreElements()) {
            resultIDList[i++] = resultsID.nextElement();
        }
        return resultIDList;
    }

    public String getGroupID() {
        return this.groupID;
    }

    public int getUserID() {
        return this.userID;
    }
}
