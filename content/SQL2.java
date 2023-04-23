package org.example;

import java.util.ArrayList;
import java.util.List;

public class SQL2 {
    public static void main(String[] args) {
        var query = select("FirstName, LastName")
                .from("People")
                .where("AGE > 25")
                .and("COUNTRY = \"USA\"")
                .orderBy("LastName")
                .build();
        System.out.println(query);
    }

    public static State.Select select(String column) {
        return new QueryBuilder().select(column);
    }

    static class QueryBuilder implements State.Select, State.From, State.Where, State.And, State.OrderBy {
        List<String> columns;
        String table;
        List<String> conditions = new ArrayList<>();
        String orderByColumn;

        public State.Select select(String column) {
            columns = List.of(column);
            return this;
        }

        @Override
        public State.From from(String table) {
            this.table = table;
            return this;
        }

        @Override
        public State.Where where(String clause) {
            this.conditions.add(clause);
            return this;
        }

        @Override
        public State.And and(String clause) {
            this.conditions.add(clause);
            return this;
        }

        @Override
        public State.OrderBy orderBy(String orderBy) {
            this.orderByColumn = orderBy;
            return this;
        }

        @Override
        public String build() {
            var selectComponent = "SELECT " + String.join("," , this.columns)
                    + " FROM " + table;

            var whereComponent = conditions.isEmpty()
                    ? ""
                    : " WHERE " + String.join(" AND ", conditions);

            var orderByComponent = orderByColumn == null
                    ? ""
                    : " ORDER BY " + orderByColumn;

            return selectComponent + whereComponent + orderByComponent;
        }
    }

    static class State {
        interface Select {
            From from(String table);
        }

        interface From {
            Where where(String clause);
            OrderBy orderBy(String orderBy);
            String build();
        }

        interface Where {
            And and(String clause);
            OrderBy orderBy(String column);
            String build();
        }

        interface And extends Where {

        }

        interface OrderBy {
            String build();
        }
    }

}
